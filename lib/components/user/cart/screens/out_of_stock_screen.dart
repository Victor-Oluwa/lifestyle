import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/models-classes/product.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Common/fonts/lifestyle_fonts.dart';
import '../../../../common/widgets/medium_text.dart';
import '../../../../state/providers/actions/provider_operations.dart';

class OutOfStockScreen extends ConsumerWidget {
  const OutOfStockScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<dynamic> outOfStocks = Get.arguments;
    return Scaffold(
      backgroundColor: LifestyleColors.kTaupeBackground,
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.only(top: 2.h, left: 5.w, right: 5.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(color: LifestyleColors.black),
                margin: EdgeInsets.only(bottom: 2.h),
                padding: EdgeInsets.all(10.sp),
                child: const MediumText(
                    overflow: TextOverflow.visible,
                    font: LifestyleFonts.kCeraMedium,
                    color: Colors.white60,
                    text:
                        'The following items are no longer available in the selected quantity. You may need to go back and update your cart accordingly.'),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: outOfStocks.map((item) {
                  final product = Product.fromMap(item['product']);
                  final requested = item['requested'];
                  return Container(
                    padding: EdgeInsets.all(10.sp),
                    margin: EdgeInsets.only(bottom: 2.h),
                    color: LifestyleColors.kTaupeDarkened,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: Row(
                        children: [
                          MediumText(
                            text: 'Name: ',
                            font: LifestyleFonts.kCeraMedium,
                            color: LifestyleColors.kTaupeBackground,
                            size: 16.sp,
                          ),
                          MediumText(
                            text: product.name,
                            color: LifestyleColors.kTaupeBackground,
                            font: LifestyleFonts.kCeraMedium,
                            size: 16.sp,
                          ),
                        ],
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              MediumText(
                                text: 'Price: ',
                                color: LifestyleColors.kTaupeBackground,
                                font: LifestyleFonts.kCeraMedium,
                                size: 15.sp,
                              ),
                              MediumText(
                                text: 'N${product.price}',
                                color: LifestyleColors.kTaupeBackground,
                                font: LifestyleFonts.kCeraMedium,
                                size: 15.sp,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              MediumText(
                                text: 'Available: ',
                                font: LifestyleFonts.kCeraMedium,
                                color: LifestyleColors.kTaupeBackground,
                                size: 15.sp,
                              ),
                              MediumText(
                                text: '${product.inStock}',
                                font: LifestyleFonts.kCeraMedium,
                                color: LifestyleColors.kTaupeBackground,
                                size: 15.sp,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              MediumText(
                                text: 'Requested: ',
                                font: LifestyleFonts.kCeraMedium,
                                color: LifestyleColors.kTaupeBackground,
                                size: 15.sp,
                              ),
                              MediumText(
                                text: '$requested',
                                font: LifestyleFonts.kCeraMedium,
                                color: LifestyleColors.kTaupeBackground,
                                size: 15.sp,
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: MediumText(
                        text: product.category,
                        font: LifestyleFonts.kComorantBold,
                        color: LifestyleColors.kTaupeBackground,
                        size: 15.sp,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
