import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Common/colors/lifestyle_colors.dart';
import '../../../../../Common/widgets/cache_image.dart';

import '../../../../models-classes/order.dart';
import '../function/profile_functions.dart';

class OrdersPageviewWidget extends StatelessWidget {
  const OrdersPageviewWidget({
    Key? key,
    required this.orders,
    required this.profileFunctions,
  }) : super(key: key);
  final List<Order> orders;
  final ProfileFunctions profileFunctions;

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(viewportFraction: 0.8);

    return SizedBox(
      height: 45.w,
      width: double.infinity,
      child: PageView.builder(
          itemCount: orders.length,
          controller: pageController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: Container(
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
                child: GestureDetector(
                  onTap: () {
                    profileFunctions.navigateOrderDetailsScreen(orders[index]);
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.sp),
                      child: networkImageCacher(
                          orders[index].products[0].images[0])),
                ),
              ),
            );
          }),
    );
  }
}
