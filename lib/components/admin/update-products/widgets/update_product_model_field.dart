// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/colors/lifestyle_colors.dart';

import '../../../../Common/widgets/medium_text.dart';
import '../../../../models-classes/product.dart';
import '../functions/update_product_fuction.dart';

class ModelField extends StatelessWidget {
  const ModelField({
    Key? key,
    required this.product,
    required this.updateProductFunction,
  }) : super(key: key);
  final Product product;
  final UpdateProductFunction updateProductFunction;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      color: Colors.white,
      borderType: BorderType.RRect,
      dashPattern: const [10, 4],
      radius: Radius.circular(15.sp),
      strokeCap: StrokeCap.round,
      child: Container(
        width: double.infinity,
        height: 20.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.sp)),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MediumText(
              text: 'Add model | Replace model',
              color: LifestyleColors.kTaupeDarkened,
            ),
          ],
        ),
      ),
    );
  }
}
