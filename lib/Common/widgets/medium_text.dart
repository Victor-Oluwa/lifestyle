// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/fonts/lifestyle_fonts.dart';

class MediumText extends StatelessWidget {
  const MediumText({
    Key? key,
    required this.text,
    this.color = LifestyleColors.kTaupeDarkened,
    this.size = 15,
    this.maxLine,
    this.font = LifestyleFonts.kComorantMedium,
    this.align = TextAlign.justify,
    this.overflow = TextOverflow.ellipsis,
    this.decoration,
  }) : super(key: key);
  final String text;
  final Color color;
  final double size;
  final int? maxLine;
  final String? font;
  final TextAlign? align;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: align,
      text,
      maxLines: maxLine,
      style: TextStyle(
          decoration: decoration,
          decorationColor: LifestyleColors.kTaupeDarkened,
          overflow: overflow,
          color: color,
          fontSize: size,
          fontFamily: font,
          fontWeight: FontWeight.bold),
    );
  }
}
