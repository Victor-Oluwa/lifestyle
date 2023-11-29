import 'package:flutter/material.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/fonts/lifestyle_fonts.dart';

class MediumText extends StatelessWidget {
  const MediumText({
    super.key,
    required this.text,
    this.color = LifestyleColors.kTaupeDarkened,
    this.size = 15,
    this.maxLine,
    this.font = LifestyleFonts.kComorantMedium,
    this.align = TextAlign.justify,
    this.overflow = TextOverflow.ellipsis,
  });
  final String text;
  final Color color;
  final double size;
  final int? maxLine;
  final String? font;
  final TextAlign? align;
  final TextOverflow? overflow;
  @override
  Widget build(BuildContext context) {
    return Text(
      // maxLines: 6,
      //  overflow: TextOverflow.ellipsis,
      textAlign: align,
      // selectionColor: Colors.grey,
      text,
      maxLines: maxLine,
      style: TextStyle(
          // letterSpacing: 5.0,
          // wordSpacing: 1.5,
          // textBaseline: TextBaseline.alphabetic,
          // height: 0.9,
          overflow: overflow,
          color: color,
          fontSize: size,
          fontFamily: font,
          fontWeight: FontWeight.bold),
    );
  }
}
