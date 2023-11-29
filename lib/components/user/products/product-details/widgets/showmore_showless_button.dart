import 'package:flutter/Material.dart';
import 'package:lifestyle/common/widgets/medium_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShowMoreShowLessButton extends StatelessWidget {
  const ShowMoreShowLessButton({
    super.key,
    required this.showFullText,
  });

  final bool showFullText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 3.w, right: 3.w, bottom: 1.h),
      alignment: Alignment.centerLeft,
      child: MediumText(
        text: showFullText == true ? "Show Less" : "Show More",
        color: Colors.white,
      ),
    );
  }
}
