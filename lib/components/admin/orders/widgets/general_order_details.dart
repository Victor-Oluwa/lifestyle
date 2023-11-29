import 'package:flutter/Material.dart';
import 'package:intl/intl.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/Common/widgets/medium_text.dart';
import 'package:lifestyle/components/user/cart/functions/cart_functions.dart';
import 'package:lifestyle/models-classes/order.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Common/colors/lifestyle_colors.dart';

class GeneralOrderDetail extends StatelessWidget {
  const GeneralOrderDetail({
    super.key,
    required this.order,
    required this.cartFunctions,
  });

  final Order order;
  final CartFunctions cartFunctions;

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
          MediumText(
            font: comorant,
            color: LifestyleColors.kTaupeDarkened,
            text: 'OrderDate: ${DateFormat().format(
              DateTime.fromMillisecondsSinceEpoch(order.orderTime),
            )}',
          ),
          SizedBox(
            height: 1.h,
          ),
          MediumText(
              font: comorant,
              color: LifestyleColors.kTaupeDarkened,
              text: 'Order id: ${order.id}'),
          SizedBox(
            height: 1.h,
          ),
          MediumText(
              font: comorant,
              color: LifestyleColors.kTaupeDarkened,
              text:
                  'Total price:  ₦${cartFunctions.addCommas('${order.totalPrice}')}'),
        ],
      ),
    );
  }
}
