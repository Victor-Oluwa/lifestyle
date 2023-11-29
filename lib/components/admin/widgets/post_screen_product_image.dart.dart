import 'package:flutter/material.dart';
import 'package:lifestyle/components/admin/all-products/functions/all_products_function.dart';
import 'package:lifestyle/models-classes/product.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Common/widgets/cache_image.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({
    Key? key,
    required this.product,
    required this.postScreenFunctoin,
  }) : super(key: key);
  final Product product;
  final AllProductFunctions postScreenFunctoin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: 20.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.sp),
        child: cacheImage(product.images[0]),
      ),
    );
  }
}
