// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:lifestyle/components/user/products/product-category/screen/product_view_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/strings/strings.dart';
import 'package:lifestyle/components/user/home/widgets/category_card.dart';

import '../../../../models-classes/category.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    Key? key,
    required this.pageController,
    required this.roomSelectorNotifier,
    required this.pageNotifier,
  }) : super(key: key);

  final PageController pageController;
  final ValueNotifier<int> roomSelectorNotifier;
  final ValueNotifier pageNotifier;

  double _getOffsetX(double percent) => percent.isNegative ? 30.0 : -30.0;

  Matrix4 _getOutTranslate(double percent, int selected, int index) {
    final x = selected != index && selected != -1 ? _getOffsetX(percent) : 0.0;
    return Matrix4.translationValues(x, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: pageNotifier,
        builder: (_, page, __) {
          return ValueListenableBuilder(
              valueListenable: roomSelectorNotifier,
              builder: (_, selected, __) {
                return PageView.builder(
                    clipBehavior: Clip.none,
                    controller: pageController,
                    itemCount: ProductCategory.values.length,
                    itemBuilder: (_, index) {
                      final isSelected = selected == index;
                      var percent = page - index;
                      final category = ProductCategory.values[index];
                      return AnimatedContainer(
                        duration: kThemeAnimationDuration,
                        curve: Curves.bounceIn,
                        // transform: _getOutTranslate(percent, selected, index),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CategoryCard(
                          category: category,
                          percent: percent,
                          expand: isSelected,
                          onTap: () async {
                            await Navigator.push(
                              context,
                              PageRouteBuilder<void>(
                                transitionDuration:
                                    const Duration(milliseconds: 800),
                                reverseTransitionDuration:
                                    const Duration(milliseconds: 800),
                                pageBuilder: (_, animation, __) =>
                                    FadeTransition(
                                  opacity: animation,
                                  child: CategoryProductsScreen(
                                    category: category,
                                  ),
                                ),
                              ),
                            );
                            // roomSelectorNotifier.value = -1;
                          },
                        ),
                      );
                    });
              });
        });
  }
}

class CircleTabBarIndicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabBarIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return CirclePainter(color: color, radius: radius);
  }
}

class CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;
    Offset circleOffset = Offset(configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - 11.w);
    canvas.drawCircle(offset + circleOffset, radius, paint);
  }
}
