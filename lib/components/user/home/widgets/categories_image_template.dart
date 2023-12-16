// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart' as x;

import 'package:lifestyle/components/user/products/product-category/screen/product_view_screen.dart';
import 'package:lifestyle/components/user/products/product-category/widgets/product_view_widget.dart';
import 'package:lifestyle/routes-management/lifestyle_routes_names.dart';

import '../../../../models-classes/category.dart';
import '../../products/product-category/widgets/parallax_image_card.dart';

class CategoryCard extends ConsumerWidget {
  const CategoryCard({
    Key? key,
    required this.category,
    required this.onTap,
    required this.percent,
    required this.expand,
  }) : super(key: key);

  void navigateToCategoryPage(BuildContext context, String category) {
    x.Get.toNamed(LifestyleRouteName.categotyRoute, arguments: category);
  }

  final ProductCategory category;
  final VoidCallback onTap;
  final double percent;
  final bool expand;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: expand ? 1 : 0),
        duration: const Duration(microseconds: 200),
        builder: (_, value, __) => Stack(
              fit: StackFit.expand,
              children: [
                // -----------------------------------------------
                // Background information card
                // -----------------------------------------------

                // -----------------------------------------------
                // Product image card with parallax effect
                // -----------------------------------------------

                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Transform(
                    transform: Matrix4.translationValues(0, -90 * value, 0),
                    child: GestureDetector(
                      onTap: onTap,
                      child: Hero(
                        tag: category.id,
                        // -----------------------------------------------
                        // Custom hero widget
                        // -----------------------------------------------
                        flightShuttleBuilder: (_, animation, __, ___, ____) {
                          return AnimatedBuilder(
                              animation: animation,
                              builder: (context, _) => Material(
                                  type: MaterialType.transparency,
                                  child: ProductView(
                                      topPadding: 0.0,
                                      animation: animation,
                                      category: category)));
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            ParallaxImageCard(
                              imageUrl: category.imageUrl,
                              parallaxValue: percent,
                            ),
                            VerticalRoomTitle(category: category),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ));
  }
}
       // navigateToCategoryPage(context, GlobalVariables.categoryTitles[index]);


/*

Container(
      height: 60.h,
      width: 90.w,
      decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.cover, image: image),
          color: color,
          borderRadius: BorderRadius.circular(5.sp)),
    );
 */