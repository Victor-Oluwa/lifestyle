import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lifestyle/Common/strings/strings.dart';
import 'package:lifestyle/components/user/products/product-category/widgets/parallax_image_card.dart';
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
    required this.isEmpty,
  }) : super(key: key);
  final List<Order> orders;
  final ProfileFunctions profileFunctions;
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(viewportFraction: 0.8);

    return PageView.builder(
        itemCount: !isEmpty ? orders.length : 7,
        controller: pageController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              !isEmpty
                  ? profileFunctions.navigateOrderDetailsScreen(orders[index])
                  : log('Order is empty');
            },
            child: Container(
              padding: EdgeInsets.only(
                top: 1.h,
                left: 2.w,
                right: 2.w,
                bottom: 3.h,
              ),
              // margin: EdgeInsets.only(bottom: 5.h),
              child: ParallaxImageCard(
                  parallaxValue: -30.0,
                  boxFit: isEmpty ? BoxFit.contain : BoxFit.cover,
                  isAsset: isEmpty ? true : false,
                  imageUrl: !isEmpty
                      ? orders[index].products[0].images[0]
                      : 'images/no_order.png'),
            ),
          );
        });
  }
}
