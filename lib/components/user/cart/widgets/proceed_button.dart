// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/Material.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/Common/widgets/medium_text.dart';
import '../functions/cart_functions.dart';

class CartProceedButton extends StatelessWidget {
  final CartFunctions cartFunctions;
  const CartProceedButton({
    Key? key,
    required this.cartFunctions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        cartFunctions.navigateToOrderDetailsScreen();
      },
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 3.w),
        decoration: const BoxDecoration(
          color: LifestyleColors.black,
        ),
        alignment: Alignment.center,
        height: 7.h,
        child: MediumText(
          font: comorant,
          text: 'PROCEED',
          size: 18.sp,
          color: LifestyleColors.white,
        ),
      ),
    );
  }
}
