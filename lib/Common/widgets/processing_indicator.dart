import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProcessingIndicator extends StatelessWidget {
  const ProcessingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Lottie.asset('assets/Loading.json'));
  }
}
