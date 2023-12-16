import 'package:flutter/Material.dart';
import 'package:lifestyle/models-classes/product.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../Common/widgets/cache_image.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      width: 50.h,
      margin: EdgeInsets.only(left: 3.w, right: 3.w, top: 1.5.h),
      decoration: const BoxDecoration(),
      child: ClipRRect(
        child: networkImageCacher(product.images[0]),
      ),
    );
  }
}
