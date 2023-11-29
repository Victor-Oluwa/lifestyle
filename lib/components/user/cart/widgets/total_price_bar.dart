import 'package:flutter/Material.dart';
import 'package:lifestyle/components/user/cart/widgets/total_price_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TotalPriceBar extends StatelessWidget {
  const TotalPriceBar({
    super.key,
  });

  // final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1.h, left: 2.w, right: 2.w, bottom: 1.h),
      height: 7.h,
      padding: EdgeInsets.only(left: 4.w, right: 4.w),
      decoration: const BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
              color: Colors.transparent, blurRadius: 15.0, spreadRadius: 15.0),
        ],
      ),
      child: const TotalPriceWidget(),
    );
  }
}
