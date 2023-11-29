// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/widgets/medium_text.dart';
import 'package:lifestyle/components/admin/update-products/functions/update_product_fuction.dart';
import 'package:lifestyle/models-classes/product.dart';

import '../../../../Common/colors/lifestyle_colors.dart';

class ImageField extends StatelessWidget {
  const ImageField({
    Key? key,
    required this.product,
    required this.updateProductFunction,
  }) : super(key: key);
  final Product product;
  final UpdateProductFunction updateProductFunction;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.white,
      borderType: BorderType.RRect,
      dashPattern: const [10, 4],
      radius: Radius.circular(15.sp),
      strokeCap: StrokeCap.round,
      child: Container(
        width: double.infinity,
        height: 20.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.sp)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MediumText(
              text: 'Replace image',
              color: LifestyleColors.kTaupeDarkened,
            ),
            Image(
              height: 13.h,
              width: 13.h,
              image: updateProductFunction.getImage(product),
            ),
          ],
        ),
      ),
    );
  }
}
