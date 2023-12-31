import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/widgets/cache_image.dart';

class ParallaxImageCard extends StatelessWidget {
  const ParallaxImageCard({
    Key? key,
    required this.imageUrl,
    this.parallaxValue = 0,
    this.isAsset = true,
    this.useTopGradient = true,
    this.boxFit = BoxFit.cover,
    this.middleColor = LifestyleColors.kTaupeBackground,
  }) : super(key: key);

  final String imageUrl;
  final double parallaxValue;
  final bool isAsset;
  final BoxFit? boxFit;
  final bool useTopGradient;
  final Color middleColor;

  BoxDecoration get _perallaxUrlImageDecoration => const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: LifestyleColors.kMiniBlack,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            // blurRadius: 12,
            blurRadius: 10,

            offset: Offset(-7, 7),
          ),
        ],
      );

  BoxDecoration get _vignetteDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: RadialGradient(
          radius: 2,
          // colors: [Colors.transparent, Colors.black],
          colors: [
            middleColor,
            middleColor,
          ],
        ),
      );

  BoxDecoration get _topVignetteDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: RadialGradient(
          radius: 2,
          colors: [
            useTopGradient
                ? LifestyleColors.kTaupeBackground.withOpacity(0.1)
                : LifestyleColors.transparent,
            useTopGradient
                ? LifestyleColors.kTaupeBackground
                : LifestyleColors.transparent,
          ],
        ),
      );

  Container get _parallaxImage => Container(
        margin: const EdgeInsets.all(10),
        child: imageProvider(
          isAsset: isAsset,
          url: imageUrl,
          parallaxValue: parallaxValue,
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(decoration: _perallaxUrlImageDecoration),
        DecoratedBox(decoration: _vignetteDecoration),
        _parallaxImage,
        DecoratedBox(decoration: _topVignetteDecoration),
      ],
    );
  }
}

dynamic imageProvider(
    {required bool isAsset,
    required String url,
    required double parallaxValue}) {
  if (isAsset) {
    return Image(
      image: AssetImage(url),
      fit: BoxFit.cover,
      colorBlendMode: BlendMode.colorBurn,
      color: LifestyleColors.kTaupeBackground.withOpacity(0.2),
      alignment: Alignment(lerpDouble(.5, -.5, parallaxValue)!, 0),
    );
  } else {
    return networkImageCacher(
      url,
      colorBlendMode: BlendMode.colorBurn,
      color: LifestyleColors.kTaupeBackground.withOpacity(0.2),
      placeHolderColor: LifestyleColors.transparent,
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
