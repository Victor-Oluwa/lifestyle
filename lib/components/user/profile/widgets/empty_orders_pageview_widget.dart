import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Common/colors/lifestyle_colors.dart';

class EmptyOrdersPageviewWidget extends StatelessWidget {
  const EmptyOrdersPageviewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(viewportFraction: 0.8);

    return SizedBox(
      height: 45.w,
      width: double.infinity,
      child: PageView.builder(
          itemCount: 7,
          controller: pageController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return buildOrderImage(index);
          }),
    );
  }

  Container buildOrderImage(int index) {
    return Container(
        padding: EdgeInsets.all(1.h),
        margin: EdgeInsets.only(bottom: 2.h, left: 5.w, top: 1.h),
        height: 34.h,
        width: 80.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: LifestyleColors.kTaupeDarkened,
          ),
          borderRadius: BorderRadius.circular(1.sp),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.sp),
          child: Image(
              height: 5.h,
              width: 5.h,
              fit: BoxFit.contain,
              image: const AssetImage('images/toplogo.png')),
        ));
  }
}
