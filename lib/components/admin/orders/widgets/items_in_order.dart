// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/Material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/Common/widgets/medium_text.dart';
import 'package:lifestyle/components/user/cart/functions/cart_functions.dart';
import 'package:lifestyle/models-classes/order.dart';

import '../../../../Common/colors/lifestyle_colors.dart';
import '../../../../Common/widgets/cache_image.dart';

class ItemsInOrder extends StatelessWidget {
  const ItemsInOrder({
    Key? key,
    required this.order,
    required this.cartFunction,
  }) : super(key: key);
  final Order order;
  final CartFunctions cartFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.topLeft,
      width: double.infinity,
      padding: EdgeInsets.all(1.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: LifestyleColors.kTaupeDarkened,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < order.products.length; i++)
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0, top: 18.0),
                  child: SizedBox(
                    height: 14.h,
                    width: 14.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.sp),
                      child: networkImageCacher(
                        order.products[i].images[0],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MediumText(
                        font: comorant,
                        text: 'Name: ${order.products[i].name}',
                        color: LifestyleColors.kTaupeDarkened,
                        maxLine: 2,
                      ),
                      MediumText(
                        font: comorant,
                        color: LifestyleColors.kTaupeDarkened,
                        text: 'Quantity: ${order.quantity[i]}'.toString(),
                      ),
                      MediumText(
                        font: comorant,
                        color: LifestyleColors.kTaupeDarkened,
                        text:
                            'Price:  ₦${cartFunction.addCommas('${order.products[i].price}')}',
                      ),
                    ],
                  ),
                )
              ],
            )
        ],
      ),
    );
  }
}
