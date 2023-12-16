// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';

class ParallaxImageCard extends StatelessWidget {
  const ParallaxImageCard({
    Key? key,
    required this.imageUrl,
    this.parallaxValue = 0,
  }) : super(key: key);

  final String imageUrl;
  final double parallaxValue;

  BoxDecoration get _perallaxUrlImageDecoration => BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: LifestyleColors.kMiniBlack,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(-7, 7),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter:
              const ColorFilter.mode(Colors.black26, BlendMode.colorBurn),
          alignment: Alignment(lerpDouble(.5, -.5, parallaxValue)!, 0),
        ),
      );

  BoxDecoration get _vignetteDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: const RadialGradient(
          radius: 2,
          colors: [Colors.transparent, Colors.black],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(decoration: _perallaxUrlImageDecoration),
        DecoratedBox(decoration: _vignetteDecoration),
      ],
    );
  }
}
