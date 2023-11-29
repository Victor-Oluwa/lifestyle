import 'package:flutter/Material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeLogoWidget extends StatelessWidget {
  const HomeLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      decoration: const BoxDecoration(),
      child: Image(
        height: 7.h,
        width: 7.h,
        image: const AssetImage('images/toplogo.png'),
      ),
    );
  }
}
