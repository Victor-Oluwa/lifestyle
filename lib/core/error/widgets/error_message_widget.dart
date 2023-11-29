import 'package:flutter/Material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Common/widgets/medium_text.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({
    super.key,
    required this.errorMessage,
  });
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      alignment: Alignment.center,
      padding: EdgeInsets.all(1.h),
      margin: EdgeInsets.all(1.h),
      child: MediumText(
        size: 25,
        text: errorMessage,
        color: Colors.white,
      ),
    );
  }
}
