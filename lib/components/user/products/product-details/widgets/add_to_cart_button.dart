import 'package:flutter/material.dart';
import 'package:lifestyle/common/widgets/app_constants.dart';
import 'package:lifestyle/common/widgets/medium_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 5.5.h,
      decoration: const BoxDecoration(color: Colors.black),
      child: MediumText(
        font: comorant,
        text: "ADD TO CART",
        color: const Color(0xFFB0A291),
      ),
    );
  }
}
