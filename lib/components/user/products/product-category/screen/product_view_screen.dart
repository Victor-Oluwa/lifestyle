import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart' as x;
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/components/user/products/product-category/provider/product_categories_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/routes-management/lifestyle_routes_names.dart';

import '../../../../../Common/widgets/medium_text.dart';

class ProductsViewScreen extends ConsumerStatefulWidget {
  const ProductsViewScreen({
    super.key,
  });

  @override
  ConsumerState<ProductsViewScreen> createState() => _ProductsViewScreenState();
}

class _ProductsViewScreenState extends ConsumerState<ProductsViewScreen> {
  navigateToProductDetailScreen(product) {
    x.Get.toNamed(LifestyleRouteName.productDetailRoute, arguments: product);
  }

  bool isConnected = true;

  final String category = x.Get.arguments;

  @override
  Widget build(BuildContext context) {
    final productCategoriesFunction =
        ref.read(productCategoriesFunctionProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: MediumText(
          font: comorant,
          text: category,
          color: Colors.white,
          size: 18.sp,
        ),
      ),
      backgroundColor: LifestyleColors.kTaupeBackground,
      body: productCategoriesFunction.buildProductsView(
          category: category, ref: ref),
    );
  }
}
