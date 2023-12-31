// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lifestyle/Common/fonts/lifestyle_fonts.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/common/widgets/app_constants.dart';
import 'package:lifestyle/common/widgets/medium_text.dart';
import 'package:lifestyle/components/user/products/product-category/provider/product_categories_provider.dart';
import 'package:lifestyle/components/user/products/product-category/widgets/parallax_image_card.dart';
import 'package:lifestyle/models-classes/product.dart';

import '../../../../../Common/widgets/cache_image.dart';
import '../../../../../core/utils/screen_utils.dart';
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
        clipBehavior: Clip.none,

        // alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          ParallaxImageCard(imageUrl: category.imageUrl),
          buildBackdrop(sigma),
          // Container(color: LifestyleColors.kTaupeBackground),
          // --------------------------------------------
          // Animated output elements
          // --------------------------------------------
          buildVerticalCategoryName(outDx),
          // --------------------------------------------
          // Animated Product Grid
          // --------------------------------------------

          buildProductGridView(ref),
        ],
      ),
    );
  }

  FadeTransition buildProductGridView(WidgetRef ref) {
    return FadeTransition(
      opacity: animation,
      child: Container(
        color: LifestyleColors.kTaupeBackground,
        transform:
            Matrix4.translationValues(0, -200 * (1 - animation.value), 0),
        padding: EdgeInsets.only(
            top: topPadding + 0.h, left: 1.h, right: 1.h, bottom: 0.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: ScreenUtils.h(0.05)),
              child: Container(
                width: double.infinity,
                height: ScreenUtils.h(0.07),
                color: LifestyleColors.transparent,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: LifestyleColors.productBackground,
                      ),
                    ),
                    SizedBox(width: ScreenUtils.h(0.05)),
                    MediumText(
                      size: ScreenUtils.w(0.06),
                      text: 'SOFA',
                      color: LifestyleColors.productBackground,
                    )
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(top: 0.h, bottom: 3.h),
            //   child: Neumorphic(
            //     padding: EdgeInsets.all(15.sp),
            //     style: const NeumorphicStyle(
            //       depth: -1,
            //       color: LifestyleColors.kTaupeBackground,
            //     ),
            //     child: NeumorphicText(
            //       textStyle: NeumorphicTextStyle(
            //         fontFamily: LifestyleFonts.kComorantBold,
            //         fontSize: 20.sp,
            //       ),
            //       style: const NeumorphicStyle(
            //         depth: 1,
            //         intensity: 500,
            //         color: LifestyleColors.kTaupeBackground,
            //       ),
            //       data[0].category.toUpperCase(),
            //     ),
            //   ),
            // ),
            Expanded(
              child: CategoryProductsGridView(
                animation: animation,
                category: category,
                data: data,
                ref: ref,
              ),
            ),
          ],
        ),
      ),
    );
  }

  FadeTransition buildVerticalCategoryName(double outDx) {
    return FadeTransition(
      opacity: Tween<double>(begin: 5, end: 0).animate(animation),
      child: Transform.translate(
        offset: Offset(-outDx, 0),
        child: VerticalCategoryName(
          category: category,
        ),
      ),
    );
  }

  ClipRRect buildBackdrop(double sigma) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: sigma, sigmaX: sigma),
        child: const ColoredBox(color: Colors.transparent),
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

  Animation<double> interval1(interval) {
    return CurvedAnimation(
      parent: animation,
      curve: Interval(interval, 1, curve: Curves.easeIn),
    );
  }

  // Animation<double> get _interval1 => CurvedAnimation(
  //       parent: animation,
  //       curve: const Interval(0.4, 1, curve: Curves.easeIn),
  //     );

  // Animation<double> get _interval2 => CurvedAnimation(
  //       parent: animation,
  //       curve: const Interval(0.6, 1, curve: Curves.easeIn),
  //     );

  // Animation<double> get _interval3 => CurvedAnimation(
  //       parent: animation,
  //       curve: const Interval(0.8, 1, curve: Curves.easeIn),
  //     );

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            LifestyleColors.kTaupeBackground,
            Colors.transparent,
            Colors.transparent,
            Colors.transparent,
          ],
          stops: [
            0.0,
            0.1,
            0.9,
            1.0
          ], // 10% purple, 80% transparent, 10% purple
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 0.5.h,
            mainAxisSpacing: 0.5.h),
        itemCount: data.length,
        cacheExtent: 100,
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
              ).animate(animation),
              child: FadeTransition(
                opacity: animation,
                child: ProductImageCard(
                  data: data,
                  index: index,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProductImageCard extends StatelessWidget {
  const ProductImageCard({
    super.key,
    required this.data,
    required this.index,
  });

  final List<Product> data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 60.h,
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
    );
  }
}

class VerticalCategoryName extends StatelessWidget {
  const VerticalCategoryName({
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
