// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/components/admin/update-products/provider/update_product_provider.dart';


import '../../../../Common/widgets/utils.dart';
import '../../../../core/params/product_upload_params.dart';
import '../../../../models-classes/product.dart';
import '../../../../state/providers/actions/provider_operations.dart';
import '../../add_product/screen/add_product_screen.dart';

class UpdateProductFunction {
  UpdateProductFunction({required this.ref});
  final Ref ref;

  final productCategories = [
    'Sofas',
    'Armchairs',
    'Tables',
    'Accessories',
    'Beds',
    'Lights'
  ];

  final statusOptions = [
    'Available',
    'Out Of Stock',
  ];

  Future<void> selectImages() async {
    var res = await pickImages();
    ref.read(updateProductImageProvider.notifier).state = res;
  }

  Future<void> selectModels() async {
    var res = await pickModel();
    ref.read(updateProductModelProvider.notifier).state = res;
  }

  Future<void> updateProduct(ProductUploadParams params,
      {required productFormKey}) async {
    ref.read(isUploadingProvider.notifier).state = true;

    final updateProductServices = ref.read(updateProductsProvider);
    final parameters = ProductUploadParams(
      id: params.id,
      name: params.name,
      description: params.description,
      category: params.category,
      status: params.status,
      inStock: params.inStock,
      price: params.price,
      images: params.images,
      models: params.models,
    );

    if (productFormKey.currentState!.validate() &&
        parameters.status.isNotEmpty) {
      await updateProductServices.updateProduct(parameters);
    }
  }

  ImageProvider getImage(Product product) {
    final images = ref.watch(updateProductImageProvider);
    if (images.isEmpty) {
      return NetworkImage(product.images[0]);
    } else {
      return FileImage(images[0]);
    }
  }
}
