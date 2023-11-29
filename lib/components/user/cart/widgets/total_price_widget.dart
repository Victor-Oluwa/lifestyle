import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/fonts/lifestyle_fonts.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/widgets/medium_text.dart';

import '../../../../state/providers/actions/provider_operations.dart';

class TotalPriceWidget extends ConsumerWidget {
  const TotalPriceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartFunction = ref.watch(cartFunctionProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.vertical,
            children: [
              MediumText(
                font: comorant,
                text: 'Total ',
                size: 18.sp,
                color: Colors.white,
              ),
              MediumText(
                font: comorant,
                color: Colors.white,
                text: 'Excluding delivery fee',
                size: 15.sp,
              )
            ],
          ),
        ),
        Row(
          children: [
            MediumText(
              font: LifestyleFonts.kComorantBold,
              text: '₦',
              size: 18.sp,
              color: Colors.white,
            ),
            MediumText(
              font: LifestyleFonts.kComorantBold,
              text: cartFunction.getSumWithComma(),
              size: 18.sp,
              color: Colors.white,
            ),
          ],
        )
      ],
    );
  }
}
// 'N${sum.toStringAsFixed(2)}',
//
