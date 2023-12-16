import 'package:flutter/material.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/strings/strings.dart';

import '../../../../models-classes/category.dart';

class CategoryPageIndicators extends StatelessWidget {
  const CategoryPageIndicators({
    super.key,
    required this.roomSelectorNotifier,
    required this.pageNotifier,
  });

  final ValueNotifier<int> roomSelectorNotifier;
  final ValueNotifier<double> pageNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: roomSelectorNotifier,
      builder: (_, value, child) => AnimatedOpacity(
        opacity: value != -1 ? 0 : 1,
        duration: value != -1
            ? const Duration(milliseconds: 1)
            : const Duration(milliseconds: 400),
        child: child,
      ),
      child: ValueListenableBuilder<double>(
        valueListenable: pageNotifier,
        builder: (_, value, __) => Center(
          child: PageViewIndicators(
            length: ProductCategory.values.length,
            pageIndex: value,
          ),
        ),
      ),
    );
  }
}

class PageViewIndicators extends StatelessWidget {
  const PageViewIndicators({
    required this.length,
    required this.pageIndex,
    super.key,
  });

  final int length;
  final double pageIndex;

  @override
  Widget build(BuildContext context) {
    final index = pageIndex;
    return SizedBox(
      height: 12,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < length; i++) ...[
                const _Dot(),
                if (i < length - 1) const SizedBox(width: 16),
              ],
            ],
          ),
          Positioned(
            left: (16 * index) + (6 * index),
            child: const _BorderDot(),
          )
        ],
      ),
    );
  }
}

class _BorderDot extends StatelessWidget {
  const _BorderDot();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 12,
      height: 12,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: LifestyleColors.black, width: 2),
          color: LifestyleColors.kTaupeBackground,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 6,
      height: 6,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: LifestyleColors.kMiniBlack,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
