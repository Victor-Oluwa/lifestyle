// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/colors/lifestyle_colors.dart';

import '../../../../Common/widgets/medium_text.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 6.5.h,
      decoration: BoxDecoration(
        color: LifestyleColors.black,
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: MediumText(
        color: Colors.white60,
        text: 'Update',
        size: 20.sp,
      ),
    );
  }
}
