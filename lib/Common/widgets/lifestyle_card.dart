import 'package:flutter/material.dart';

import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LifestyleCard extends StatelessWidget {
  const LifestyleCard({
    Key? key,
    required this.cardChild,
    required this.cardWidth,
    this.cardColor = LifestyleColors.kTaupeBackground,
  }) : super(key: key);

  final Widget cardChild;
  final double cardWidth;
  final Color cardColor;

  BoxDecoration get _cardShadowDecoration => const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3)),
        color: LifestyleColors.kMiniBlack,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(-7, 7),
          ),
        ],
      );

  BoxDecoration get _solidVignetteDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        gradient: RadialGradient(
          radius: 2,
          colors: [
            cardColor,
            cardColor,
          ],
        ),
      );

  // BoxDecoration get _topVignetteDecoration => BoxDecoration(
  //       borderRadius: BorderRadius.circular(3),
  //       gradient: RadialGradient(
  //         radius: 2,
  //         colors: [
  //           LifestyleColors.kTaupeBackground.withOpacity(0.1),
  //           LifestyleColors.kTaupeBackground,
  //         ],
  //       ),
  //     );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: cardWidth,
          child: DecoratedBox(
            decoration: _cardShadowDecoration,
            child: cardChild,
          ),
        ),
        SizedBox(
          width: cardWidth,
          child: DecoratedBox(
            decoration: _solidVignetteDecoration,
            child: cardChild,
          ),
        ),
        // SizedBox(
        //   width: cardWidth,
        //   child: DecoratedBox(
        //     decoration: _topVignetteDecoration,
        //     child: cardChild,
        //   ),
        // ),
      ],
    );
  }
}
