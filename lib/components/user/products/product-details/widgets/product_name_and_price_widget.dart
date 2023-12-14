import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/common/widgets/app_constants.dart';
import 'package:lifestyle/common/widgets/medium_text.dart';
import 'package:lifestyle/models-classes/product.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductNameAndPrice extends StatelessWidget {
  const ProductNameAndPrice({
    super.key,
    required this.ref,
    required this.product,
  });

  final Product product;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final cartFunction = ref.read(cartFunctionProvider);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            height: 3.5.h,
            margin: EdgeInsets.only(top: 1.h),
            padding: EdgeInsets.symmetric(horizontal: 4.5.w),
            decoration: const BoxDecoration(color: Colors.white),
            child: MediumText(
              size: 15.sp,
              font: comorant,
              text: product.name.toUpperCase(),
              color: Colors.black,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 3.5.h,
            margin: EdgeInsets.only(top: 1.h),
            padding: EdgeInsets.symmetric(horizontal: 4.5.w),
            decoration: const BoxDecoration(color: Colors.white),
            child: MediumText(
              size: 15.sp,
              text:
                  '₦${cartFunction.getProductPriceWithCommas('${product.price}')}',
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
