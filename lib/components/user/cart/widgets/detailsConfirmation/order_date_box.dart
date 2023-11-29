import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../Common/colors/lifestyle_colors.dart';
import '../../../../../Common/fonts/lifestyle_fonts.dart';
import '../../../../../Common/widgets/medium_text.dart';
import '../../../../../models-classes/user.dart';

class OrderDateBox extends StatelessWidget {
  const OrderDateBox({
    super.key,
    required this.formattedDate,
    required this.user,
  });

  final String formattedDate;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85.w,
      padding: EdgeInsets.all(1.h),
      alignment: Alignment.topLeft,
      decoration: const BoxDecoration(color: LifestyleColors.kTaupeDarkened),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MediumText(
            text: "Review Info",
            font: LifestyleFonts.kComorantBold,
            size: 20.sp,
            color: Colors.white,
          ),
          MediumText(
            text: formattedDate,
            size: 15.sp,
            font: LifestyleFonts.kComorantBold,
            color: Colors.white,
          ),
          Row(
            children: [
              MediumText(
                text: "Buyer: ",
                font: LifestyleFonts.kComorantBold,
                size: 15.sp,
                color: Colors.white,
              ),
              MediumText(
                text: user.name,
                font: LifestyleFonts.kComorantBold,
                size: 15.sp,
                color: Colors.white,
              ),
            ],
          )
        ],
      ),
    );
  }
}
