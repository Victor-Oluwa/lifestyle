import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:lifestyle/components/admin/add_product/screen/add_product_screen.dart';

import '../../../../Common/widgets/app_constants.dart';
import '../../../../core/error/exception/api_exception.dart';
import '../../../../Common/widgets/utils.dart';
import '../../../../models-classes/product.dart';
import '../../../../models-classes/user.dart';
import '../../../../state/providers/actions/provider_operations.dart';
import '../../../../state/providers/provider_model/user_provider.dart';

final modelUploadProgressState = StateProvider((ref) => 0.0);

class AddProductServices {
  final Ref ref;
  final FirebaseStorage firebaseStorage;
  AddProductServices({
    required this.ref,
    required this.firebaseStorage,
  });

  /*Uploads MODEL file to Firebase storage and get a download url
  which is then passed in the http request body as the product model*/
  Future<List<String>> getModelUrl(
      {required String productName, required List<File> models}) async {
    if (models.isEmpty) {
      log('Model is empty');
      return [];
    }
    List<String> modelUrl = [];
    final filePath = '$productName/model/$productName.glb';
    for (var i = 0; i < models.length; i++) {
      final file = File(models[i].path);
      final Reference reference = firebaseStorage.ref().child(filePath);

      final UploadTask task = reference.putFile(file);
      task.snapshotEvents.listen((TaskSnapshot snapshot) {
        ref.watch(modelUploadProgressState.notifier).state =
            (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      }, onError: (e) {
        log('$e');
      });
      final TaskSnapshot snapshot = await task.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      modelUrl.add(downloadUrl);
    }
    return modelUrl;
  }

  /*Upload IMAGE file to Firebase storage and get a download url
  which is then passed in the http request body as the product image*/
  Future<List<String>> getImageUrl(
      {required String productName, required List<File> images}) async {
    List<String> imageUrl = [];
    for (var i = 0; i < images.length; i++) {
      final Reference reference =
          firebaseStorage.ref().child('$productName/image/$productName');
      final UploadTask task = reference.putFile(File(images[i].path));
      final TaskSnapshot snapshot =
          await task.whenComplete(() => log('Image Uploaded'));
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrl.add(downloadUrl);
    }

    return imageUrl;
  }

  Future<String> addNewProduct({
    required BuildContext context,
    required String productName,
    required String description,
    required String category,
    required int inStock,
    required double price,
    required String createdAt,
    required final String date,
    String status = 'Available',
    required List<File> images,
    required List<File> models,
  }) async {
    String result = '';

    try {
      final User user = ref.read(userProvider);
      List<String> modelUrls =
          await getModelUrl(productName: productName, models: models);
      List<String> imageUrls =
          await getImageUrl(productName: productName, images: images);

      Product product = Product(
        id: '',
        createdAt: createdAt,
        status: status,
        name: productName,
        description: description,
        inStock: inStock,
        inCart: 0,
        price: price,
        category: category,
        images: imageUrls,
        models: modelUrls,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-new-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          AppConstants.authToken: user.token,
        },
        body: product.toJson(),
      );

      if (res.statusCode == 200) {
        dropperMessage('SUCCESS', 'Products added successfully!');
        final Product response = Product.fromJson(res.body);

        //Assign http response to result
        result = jsonEncode(response);

        /*Invalidates the fetchAllProductsProvider(FutureProvider) 
      in order to rebuild the product list */
        ref.invalidate(fetchAllProductsProvider);
      } else {
        throw APIException(message: res.body, statusCode: res.statusCode);
      }
    } on APIException catch (e) {
      dropperMessage('ATTENTION', 'An error occured while uploading item');
      log('Failed to upload product ${e.statusCode} Error: ${e.message}');
    } catch (e) {
      dropperMessage('ATTENTION', 'An error occured while uploading item');
      log('Failed to add product: $e');
    }

    /*Sets isUploading provider to false when operation is finished
      either with an error or with success which will stop the uploading 
      progress indicator*/

    ref.read(isUploadingProvider.notifier).state = false;
    return result;
  }
}
