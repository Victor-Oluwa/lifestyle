import 'package:flutter/material.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Common/widgets/medium_text.dart';
import '../../../../Common/widgets/utils.dart';

class ArBlankPage extends StatelessWidget {
  const ArBlankPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const MediumText(
          text: 'COMING SOON',
          color: LifestyleColors.kTaupeBackground,
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            color: Colors.black,
            child: Image.asset(
              height: 30.h,
              width: 30.h,
              'images/ARw.png',
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Container(
            padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
            width: 78.w,
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MediumText(
                  text: 'AR MODE',
                  size: 20.sp,
                ),
                Container(
                  padding: EdgeInsets.only(left: 3.w, right: 3.w),
                  child: MediumText(
                      align: TextAlign.center,
                      size: 14.sp,
                      maxLine: 4,
                      text:
                          'Utilizing augmented reality (AR) technology, this feature allows you to seamlessly position furniture pieces in your real-world environment, offering a preview of how they would appear in your space before making a purchase. '),
                ),
                SizedBox(
                  height: 1.h,
                ),
                GestureDetector(
                  onTap: () {
                    dropperMessage('COMING SOON',
                        "Oops! You've stumbled into the future! This feature is currently under construction by our team of tech wizards. Stay tuned for the magic to unfold!",
                        duration: const Duration(seconds: 10));
                    // Get.toNamed(LifestyleRouteName.arRoute);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    // height: 3.h,
                    width: 35.w,
                    decoration: const BoxDecoration(
                        color: LifestyleColors.kTaupeDarkened),
                    child: const MediumText(
                      text: 'PROCEED',
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
