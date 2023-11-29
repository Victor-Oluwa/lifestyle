import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/common/widgets/medium_text.dart';
import 'package:lifestyle/models-classes/product.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../state/providers/actions/provider_operations.dart';

class ThreeDViewButton extends StatelessWidget {
  const ThreeDViewButton({
    super.key,
    required this.ref,
    required this.product,
  });

  final WidgetRef ref;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          ref
              .read(productDetailsFunctionProvider)
              .navigateToModelScreen(product);
        },
        child: Padding(
          padding: EdgeInsets.only(right: 7.w, top: 2.5.h),
          child: Column(
            children: [
              Image.asset(
                'images/3Db.png',
                height: 3.5.h,
              ),
              const MediumText(
                text: '3D',
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
