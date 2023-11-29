// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/widgets/medium_text.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({
    Key? key,
    required this.onRefresh,
    this.buttonText,
  }) : super(key: key);
  final VoidCallback onRefresh;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: LifestyleColors.kTaupeBackground,
            ),
            alignment: Alignment.center,
            child: Lottie.asset(
              'assets/internet.json',
              delegates: LottieDelegates(
                text: (initialText) => '**$initialText**',
                values: [
                  ValueDelegate.color(
                    const ['Shape Layer 1', 'Rectangle', 'Fill 1'],
                    value: Colors.red,
                  ),
                  ValueDelegate.opacity(
                    const ['Shape Layer 1', 'Rectangle'],
                    callback: (frameInfo) =>
                        (frameInfo.overallProgress * 100).round(),
                  ),
                  ValueDelegate.position(
                    const ['Shape Layer 1', 'Rectangle', '**'],
                    relative: const Offset(100, 200),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: onRefresh,
              icon: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.sp),
                    color: LifestyleColors.kMiniBlack,
                  ),
                  height: 5.h,
                  width: 40.w,
                  child: MediumText(text: buttonText ?? 'Refresh')))
        ],
      ),
    );
  }
}
