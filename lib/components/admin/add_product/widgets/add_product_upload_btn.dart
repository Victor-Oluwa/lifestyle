import 'package:flutter/material.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/widgets/medium_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddProductUploadButton extends StatelessWidget {
  const AddProductUploadButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 6.5.h,
      decoration: BoxDecoration(
        color: LifestyleColors.kTaupeDarkened,
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: MediumText(
        color: Colors.white60,
        text: 'Upload',
        size: 20.sp,
      ),
    );
  }
}
