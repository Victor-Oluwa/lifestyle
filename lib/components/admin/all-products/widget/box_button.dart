import 'package:flutter/Material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BoxButton extends StatelessWidget {
  final Widget icon;
  final BoxBorder? border;
  final EdgeInsetsGeometry? margin;
  final Color color;

  const BoxButton({
    Key? key,
    required this.icon,
    this.border,
    this.margin,
    this.color = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h, left: 3.w, right: 3.w),
      child: Container(
        margin: margin,
        alignment: Alignment.center,
        //  margin: const EdgeInsets.only(bottom: 15),
        height: 6.h,
        width: 20.w,
        decoration: BoxDecoration(
          // boxShadow: [BoxShadow(color: color, blurRadius: 7, spreadRadius: 7)],
          border: border,
          borderRadius: BorderRadius.circular(5.sp),
          // color: Colors.black,
        ),
        child: icon,
      ),
    );
  }
}
