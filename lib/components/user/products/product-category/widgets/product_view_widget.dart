// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lifestyle/Common/fonts/lifestyle_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/common/widgets/app_constants.dart';
import 'package:lifestyle/common/widgets/medium_text.dart';
import 'package:lifestyle/components/user/products/product-category/provider/product_categories_provider.dart';
import 'package:lifestyle/components/user/products/product-category/widgets/parallax_image_card.dart';
import 'package:lifestyle/models-classes/product.dart';

import '../../../../../Common/widgets/cache_image.dart';
import '../../../../../models-classes/category.dart';

class CategoryProductItem extends ConsumerWidget {
  const CategoryProductItem({
    Key? key,
    this.animation = const AlwaysStoppedAnimation<double>(1),
    required this.topPadding,
    required this.data,
    required this.category,
  }) : super(key: key);

  final Animation<double> animation;
  final double topPadding;
  final List<Product> data;
  final ProductCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outDx = 200 * animation.value;
    // final outDy = 100 * animation.value;
    final sigma = 10 * animation.value;
    return Hero(
      tag: category.id,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          ParallaxImageCard(imageUrl: category.imageUrl),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: sigma, sigmaX: sigma),
              child: const ColoredBox(color: Colors.transparent),
            ),
          ),
          // --------------------------------------------
          // Animated output elements
          // --------------------------------------------

          FadeTransition(
            opacity: Tween<double>(begin: 1, end: 0).animate(animation),
            child: Stack(children: [
              Transform.translate(
                offset: Offset(-outDx, 0),
                child: VerticalRoomTitle(
                  category: category,
                ),
              ),
              // Transform.translate(
              //   offset: Offset(outDx, outDy),
              //   child: const CameraIconButton(),
              // ),
              // Transform.translate(
              //   offset: Offset(0, outDy),
              //   child: const AnimatedUpwardArrows(),
              // ),
            ]),
          ),
          // --------------------------------------------
          // Animated room controls
          // --------------------------------------------

          FadeTransition(
            opacity: animation,
            child: Container(
              transform:
                  Matrix4.translationValues(0, -200 * (1 - animation.value), 0),
              padding: EdgeInsets.only(
                  top: topPadding + 12, left: 1.h, right: 1.h, bottom: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Text(
                  //   'SOFA'.replaceAll(' ', '\n'),
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(),
                  // ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        return Future.delayed(const Duration(seconds: 3)).then(
                            (value) =>
                                ref.invalidate(getCategoryProductProvider));
                      },
                      child: CategoryProductsGridView(
                        animation: animation,
                        category: category,
                        data: data,
                        ref: ref,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryProductsGridView extends StatelessWidget {
  const CategoryProductsGridView({
    Key? key,
    required this.data,
    required this.ref,
    required this.animation,
    required this.category,
  }) : super(key: key);

  final List<Product> data;
  final WidgetRef ref;

  final Animation<double> animation;
  final ProductCategory category;

  Animation<double> get _interval1 => CurvedAnimation(
        parent: animation,
        curve: const Interval(0.4, 1, curve: Curves.easeIn),
      );

  Animation<double> get _interval2 => CurvedAnimation(
        parent: animation,
        curve: const Interval(0.6, 1, curve: Curves.easeIn),
      );

  Animation<double> get _interval3 => CurvedAnimation(
        parent: animation,
        curve: const Interval(0.8, 1, curve: Curves.easeIn),
      );

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      physics: const BouncingScrollPhysics(),
      itemCount: data.length,
      crossAxisCount: 2,
      mainAxisSpacing: 5,
      cacheExtent: 100,
      crossAxisSpacing: 5,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (() {
            ref
                .read(productCategoriesFunctionProvider)
                .goToProductDetailScreen(product: data[index]);
          }),
          child: SlideTransition(
            position: Tween(
              begin: const Offset(0, 2),
              end: Offset.zero,
            ).animate(_interval1),
            child: FadeTransition(
              opacity: _interval1,
              child: Stack(
                children: [
                  Container(
                    height: 40.h,
                    width: 52.w,
                    decoration: BoxDecoration(
                      color: LifestyleColors.productBackground,
                      borderRadius: BorderRadius.circular(5.sp),
                    ),
                    child: networkImageCacher(
                      placeHolderColor: LifestyleColors.productBackground,
                      data[index].images[0],
                    ),
                  ),
                  Positioned(
                    bottom: 0.4.h,
                    right: 1.5.w,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: MediumText(
                        text: data[index].name,
                        size: 15.sp,
                        font: comorant,
                        color: Colors.black,
                        // size: ,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class VerticalRoomTitle extends StatelessWidget {
  const VerticalRoomTitle({
    required this.category,
    super.key,
  });

  final ProductCategory category;

  @override
  Widget build(BuildContext context) {
    // final dx = 50 * animationValue;
    // final opacity = 1 - animationValue;
    return Align(
      alignment: Alignment.centerLeft,
      child: RotatedBox(
        quarterTurns: -1,
        child: FittedBox(
          child: Padding(
            padding: EdgeInsets.only(left: 40.h, right: 20.h, top: 12.w),
            child: Text(
              category.name.toUpperCase(),
              maxLines: 1,
              style: TextStyle(
                fontSize: 40.sp,
                fontFamily: LifestyleFonts.kComorantMedium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
