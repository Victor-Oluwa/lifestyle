import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../Common/colors/lifestyle_colors.dart';
import '../../../../../Common/fonts/lifestyle_fonts.dart';
import '../../../../../Common/widgets/medium_text.dart';
import '../../functions/cart_functions.dart';

class OrderCostBox extends StatelessWidget {
  const OrderCostBox({
    super.key,
    required this.cartFunction,
  });

  final CartFunctions cartFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.h),
      height: 15.h,
      width: 85.w,
      decoration: const BoxDecoration(color: LifestyleColors.kTaupeDarkened),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MediumText(
                color: Colors.white,
                text: 'Order',
                font: LifestyleFonts.kComorantBold,
                size: 17.sp,
              ),
              MediumText(
                color: Colors.white,
                text: '₦${cartFunction.getSumWithComma()}',
                font: LifestyleFonts.kComorantBold,
                size: 15.sp,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MediumText(
                color: Colors.white,
                text: 'Fee',
                font: LifestyleFonts.kComorantBold,
                size: 15.sp,
              ),
              MediumText(
                color: Colors.white,
                text: '₦${cartFunction.addCommas('0.0')}',
                font: LifestyleFonts.kComorantBold,
                size: 15.sp,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MediumText(
                color: Colors.white,
                text: 'Subtotal',
                font: LifestyleFonts.kComorantBold,
                size: 15.sp,
              ),
              MediumText(
                color: Colors.white,
                text: '₦${cartFunction.getSumWithComma()}',
                font: LifestyleFonts.kComorantBold,
                size: 15.sp,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MediumText(
                color: Colors.white,
                text: 'Vat',
                font: LifestyleFonts.kComorantBold,
                size: 15.sp,
              ),
              MediumText(
                color: Colors.white,
                text: '₦${cartFunction.addCommas('0.0')}',
                font: LifestyleFonts.kComorantBold,
                size: 15.sp,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MediumText(
                color: Colors.white,
                text: 'Total',
                font: LifestyleFonts.kComorantBold,
                size: 15.sp,
              ),
              MediumText(
                color: Colors.white,
                text: '₦${cartFunction.getSumWithComma()}',
                font: LifestyleFonts.kComorantBold,
                size: 15.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
