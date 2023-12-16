// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart' as x;
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/components/user/products/product-category/provider/product_categories_provider.dart';
import 'package:lifestyle/routes-management/lifestyle_routes_names.dart';

import '../../../../../Common/widgets/medium_text.dart';
import '../../../../../models-classes/category.dart';

class ProductsViewScreen extends ConsumerWidget {
  const ProductsViewScreen({
    super.key,
    required this.category,
  });

  final ProductCategory category;

  navigateToProductDetailScreen(product) {
    x.Get.toNamed(LifestyleRouteName.productDetailRoute, arguments: product);
  }

  // x.Get.arguments;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: MediumText(
          font: comorant,
          text: category.name.toUpperCase(),
          color: Colors.white,
          size: 18.sp,
        ),
      ),
      backgroundColor: LifestyleColors.kTaupeBackground,
      body: ProductView(
        topPadding: 0.0,
        category: category,
      ),
    );
  }
}

class ProductView extends ConsumerWidget {
  const ProductView({
    super.key,
    required this.category,
    this.animation = const AlwaysStoppedAnimation<double>(1),
    required this.topPadding,
  });
  final ProductCategory category;
  final Animation<double> animation;
  final double topPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productCategoriesFunction =
        ref.watch(productCategoriesFunctionProvider);
    return productCategoriesFunction.buildProductsView(
        animation: animation, topPadding: 0.0, category: category, ref: ref);
  }
}
