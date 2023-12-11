// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:lifestyle/state/providers/provider_model/user_provider.dart';
import 'package:lifestyle/models-classes/user.dart';

import '../../../../Common/widgets/app_constants.dart';
import '../../../../Common/widgets/utils.dart';
import '../../../../core/error/exception/api_exception.dart';
import '../../../../core/params/product_upload_params.dart';
import '../../../../models-classes/product.dart';
import '../../../../state/providers/actions/provider_operations.dart';
import '../../add_product/screen/add_product_screen.dart';

class UpdateProductServices {
  UpdateProductServices({
    required this.ref,
    required this.firebaseStorage,
  });
  final Ref ref;
  final FirebaseStorage firebaseStorage;

  Future<List<String>> getModels(ProductUploadParams params) async {
    List<String> modelUrls = [];

    if (params.models.isNotEmpty) {
      for (var model in params.models) {
        final Reference ref = firebaseStorage
            .ref()
            .child('${params.name}/model/${params.name}.glb');
        final UploadTask task = ref.putFile(File(model.path));
        await task.whenComplete(() => log('Model Uploaded'));
        final String downloadUrl = await ref.getDownloadURL();
        modelUrls.add(downloadUrl);
      }
    }

    return modelUrls;
  }

  Future<List<String>> getImages(ProductUploadParams params) async {
    List<String> imageUrls = [];

    if (params.images.isNotEmpty) {
      for (var image in params.images) {
        final Reference ref = firebaseStorage
            .ref()
            .child('Products/${params.name}/image/${params.name}');
        final UploadTask task = ref.putFile(File(image.path));
        await task.whenComplete(() => log('Image Uploaded'));
        final String downloadUrl = await ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      }
    }

    return imageUrls;
  }

  Future<void> updateProduct(
    ProductUploadParams params,
  ) async {
    try {
      final User user = ref.read(userProvider);
      final images = await getImages(params);
      final models = await getModels(params);
      Product product = Product(
        id: params.id,
        name: params.name,
        description: params.description,
        inStock: params.inStock,
        inCart: 0,
        price: params.price,
        category: params.category,
        status: params.status,
        images: images,
        models: models,
      );

      http.Response res = await http.put(
        Uri.parse('$uri/admin/update-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          AppConstants.authToken: user.token,
        },
        body: product.toJson(),
      );

      if (res.statusCode == 200) {
        dropperMessage('COMPLETED', 'Product updated successfully');
        ref.invalidate(fetchAllProductsProvider);
      } else {
        throw APIException(message: res.body, statusCode: res.statusCode);
      }
    } on APIException catch (e) {
      dropperMessage('ATTENTION', 'An error occured while uploading item');
      log('Failed to upload product ${e.statusCode} Error: ${e.message}');
    } catch (e) {
      dropperMessage('ATTENTION', 'An error occured while updating item');
      log('Failed to update product: $e');
    }

    ref.read(isUploadingProvider.notifier).state = false;
  }
}
