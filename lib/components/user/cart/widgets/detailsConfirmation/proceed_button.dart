// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../Common/fonts/lifestyle_fonts.dart';
import '../../../../../Common/widgets/medium_text.dart';

class OrderDetailsProceedButton extends StatelessWidget {
  const OrderDetailsProceedButton({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Container(
        color: LifestyleColors.black,
        height: 8.h,
        width: double.infinity,
        // padding: EdgeInsets.all(1.h),
        alignment: Alignment.center,
        child: MediumText(
          color: LifestyleColors.white,
          text: text.toUpperCase(),
          size: 18.sp,
          font: LifestyleFonts.kComorantBold,
        ),
      ),
    );
  }
}
