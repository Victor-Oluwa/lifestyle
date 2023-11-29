// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/Material.dart';
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
    return IconButton(
      onPressed: () {
        cartFunctions.navigateToOrderDetailsScreen();
      },
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              alignment: Alignment.center,
              height: 7.h,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 2.w,
                children: [
                  MediumText(
                    font: comorant,
                    text: 'Proceed'.toUpperCase(),
                    size: 18.sp,
                    color: const Color(0xFFB0A291),
                  ),
                  Icon(
                    Icons.arrow_right,
                    size: 25.sp,
                    color: const Color(0xFFB0A291),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
