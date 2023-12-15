// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/components/admin/add_product/provider/add_product_provider.dart';

import '../../../../Common/widgets/processing_indicator.dart';
import '../../../../Common/widgets/utils.dart';
import '../../../../state/providers/actions/provider_operations.dart';
import '../screen/add_product_screen.dart';

class AddProductFunctions {
  final Ref ref;
  AddProductFunctions({required this.ref});
  //Initialize|Declaration

  final _addProductFormKey = GlobalKey<FormState>();
  GlobalKey get addProductFormKey => _addProductFormKey;

  String? _category;
  final _productCategories = [
    'Sofas',
    'Armchairs',
    'Tables',
    'Accessories',
    'Beds',
    'Lights'
  ];

  String? get category => _category;
  List<String> get productCategories => _productCategories;

  //setters
  set setCategory(String value) {
    _category = value;
  }

/*Picks image file and update's the
product images provider */
  Future<void> selectImages() async {
    var imageFile = await pickImages();
    ref.read(addProductImageProvider.notifier).state = imageFile;
    log('Picked image..');
  }

/*Picks model file and update's the
product images provider */
  Future<void> selectModels() async {
    var modelFile = await pickImages();
    ref.read(addProductModelProvider.notifier).state = modelFile;
    log('Picked model..');
  }

  Future<String> addProduct({
    required context,
    required String name,
    required String description,
    required String inStock,
    required String price,
  }) async {
    //Declaration of used providers
    final addProductServices = ref.read(addProductServicesProvider);
    final images = ref.read(addProductImageProvider);
    final models = ref.read(addProductModelProvider);
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      /*Make isUploadingProvider true 
      to show the uploading progress indicator*/
      ref.read(isUploadingProvider.notifier).state = true;

      return await addProductServices.addNewProduct(
        createdAt: DateTime.now().toIso8601String(),
        context: context,
        productName: name,
        description: description,
        category: _category!,
        date: DateTime.now().toString(),
        inStock: int.parse(inStock),
        price: double.parse(
          price,
        ),
        images: images,
        models: models,
      );
    } else {
      return '';
    }
  }

  /*Activates the uploading progress indicator
  when isUploading provider is set to true
  
  This function is called in the add product main
  screen */
  Widget showUploadingProgressIndicator(bool isUploading) {
    return isUploading ? const ProcessingIndicator() : const Text('');
  }
}
