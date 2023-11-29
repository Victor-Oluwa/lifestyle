import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image(
          height: 15.h,
          width: 15.h,
          image: const AssetImage('images/toplogo.png')),
    );
  }
}
