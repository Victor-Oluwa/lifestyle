import 'package:flutter/material.dart';
import 'package:lifestyle/components/user/cart/functions/cart_functions.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../Common/colors/lifestyle_colors.dart';
import '../../../../../Common/fonts/lifestyle_fonts.dart';
import '../../../../../Common/widgets/medium_text.dart';
import '../../../../../models-classes/product.dart';
import '../../../../../models-classes/user.dart';

class OrderProductsBox extends StatelessWidget {
  const OrderProductsBox({
    super.key,
    required this.user,
    required this.cartFunctions,
  });
  final User user;
  final CartFunctions cartFunctions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.h),
      width: 85.w,
      decoration: const BoxDecoration(color: LifestyleColors.kTaupeDarkened),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MediumText(
            color: Colors.white,
            text: 'Items',
            font: LifestyleFonts.kComorantBold,
            size: 16.sp,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: user.cart.map((cart) {
              final product = Product.fromMap(cart['product']);
              final quantity = cart['quantity'];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                title: MediumText(
                  color: Colors.white,
                  text: product.name,
                  font: LifestyleFonts.kComorantBold,
                  size: 16.sp,
                ),
                subtitle: MediumText(
                  color: Colors.white,
                  text: '₦${cartFunctions.addCommas('${product.price}')}',
                  font: LifestyleFonts.kComorantBold,
                  size: 15.sp,
                ),
                trailing: MediumText(
                  color: Colors.white,
                  text: '$quantity',
                  font: LifestyleFonts.kComorantBold,
                  size: 15.sp,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
