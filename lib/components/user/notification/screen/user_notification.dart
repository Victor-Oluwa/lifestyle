import 'package:flutter/Material.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/strings/strings.dart';
import 'package:lifestyle/Common/widgets/medium_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserNotification extends StatelessWidget {
  const UserNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LifestyleColors.kTaupeBackground,
      body: SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: LifestyleColors.shadowColor,
                  ),
                  child: Image(
                      height: 30.h,
                      image: const AssetImage(
                        LifestyleAssetImages.whiteLogoImage,
                      )),
                ),
                SizedBox(height: 2.h),
                Container(
                  margin: EdgeInsets.all(1.h),
                  child: Column(
                    children: [
                      MediumText(
                          size: 22.sp,
                          color: LifestyleColors.kTaupeDarkened,
                          text: 'Title To A New Notification'),
                      SizedBox(height: 2.h),
                      const MediumText(
                          color: LifestyleColors.kTaupeDarkened,
                          align: TextAlign.justify,
                          overflow: TextOverflow.visible,
                          text:
                              'veryLongString veryLongString veryLongString veryLongString veryLongString veryLongString veryLongString veryLongString veryLongString veryLongString veryLongString veryLongString veryLongString veryLongString veryLongString veryLongString veryLongString veryLongString '),
                      SizedBox(height: 7.h),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: IconButton(
              padding: const EdgeInsets.all(0.0),
              onPressed: () {},
              icon: Container(
                width: double.infinity,
                height: 7.h,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: LifestyleColors.black),
                child: const MediumText(
                    color: LifestyleColors.white, text: 'PROCEED'),
              ),
            ),
          )
        ],
      )),
    );
  }
}
