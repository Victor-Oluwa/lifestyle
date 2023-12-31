import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/widgets/lifestyle_card.dart';
import 'package:lifestyle/Common/widgets/medium_text.dart';
import 'package:lifestyle/components/user/products/product-category/widgets/parallax_image_card.dart';
import 'package:lifestyle/core/utils/screen_utils.dart';
import 'package:lifestyle/models-classes/product.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart' as x;

import '../../../../../Common/widgets/processing_indicator.dart';
import '../../../../../core/bouncer/provider/bouncer_provider.dart';
import '../../../../../state/providers/actions/provider_operations.dart';
import '../functions/product_details_functions.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _controller;
  late Product product;
  late AnimationController _animationController;
  late Animation<Offset> _animation1;

  late Animation<Offset> _animation2;
  late Animation<Offset> _animation3;

  late Animation<Offset> _animation4;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();
    product = x.Get.arguments;

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void didChangeDependencies() {
    _animation1 = Tween<Offset>(
      begin: Offset(-MediaQuery.of(context).size.width, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutQuart,
    ))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<Offset>(
      begin: Offset(MediaQuery.of(context).size.width, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutQuart,
    ))
      ..addListener(() {
        setState(() {});
      });

    _animation3 = Tween<Offset>(
      begin: Offset(0.0, -100),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInSine,
    ))
      ..addListener(() {
        setState(() {});
      });

    _animation4 = Tween<Offset>(
      begin: Offset(0.0, MediaQuery.of(context).size.height),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutQuart,
    ))
      ..addListener(() {
        setState(() {});
      });

    ref.invalidate(isProcessingProvider);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.removeListener(() {
      setState(() {});
    });
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isProcessing = ref.watch(isProcessingProvider);
    final ProductDetailsFunctions productDetailsFunctions =
        ref.watch(productDetailsFunctionProvider);
    final bool showFullText = ref.watch(showFullTextProvider);

    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
        ),
        backgroundColor: LifestyleColors.productBackground,
      ),
      backgroundColor: LifestyleColors.productBackground,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: ScreenUtils.h(0.45),
                width: ScreenUtils.w(0.90),
                // color: LifestyleColors.kTaupeDarkened,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildNameAndCategoryText(),
                    SizedBox(height: ScreenUtils.h(0.02)),
                    buildExpandBtnAndDescriptionText(showFullText),
                    SizedBox(height: ScreenUtils.h(0.01)),
                    buildDescription(showFullText),
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: buildPriceAndActionButtonRow(productDetailsFunctions)),
            Align(
              alignment: Alignment.topCenter,
              child: buildProductImage(),
            ),

            isProcessing ? const ProcessingIndicator() : const Text('')
//           // const ProcessingIndicator()
          ],
        ),
      ),
    );
  }

  Transform buildNameAndCategoryText() {
    return Transform.translate(
      offset: _animation1.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MediumText(
            size: ScreenUtils.w(0.04),
            text: product.category,
            color: LifestyleColors.black.withOpacity(0.5),
          ),
          MediumText(
            text: product.name,
            size: ScreenUtils.w(0.06),
          ),
        ],
      ),
    );
  }

  Row buildExpandBtnAndDescriptionText(bool showFullText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Transform.translate(
          offset: _animation1.value,
          child: MediumText(
            text: 'Description',
            size: ScreenUtils.w(0.04),
            color: LifestyleColors.black.withOpacity(0.8),
          ),
        ),
        InkWell(
          onTap: () {
            ref
                .watch(showFullTextProvider.notifier)
                .update((state) => state = !showFullText);

            if (!showFullText) {
              _controller.animateTo(1000,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOutQuart);
            } else {
              _controller.animateTo(-1000,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOutQuart);
            }
          },
          child: Transform.translate(
            offset: _animation2.value,
            child: Icon(
              showFullText ? Icons.minimize_outlined : Icons.add,
              color: LifestyleColors.black,
            ),
          ),
        )
      ],
    );
  }

  Transform buildDescription(bool showFullText) {
    return Transform.translate(
      offset: _animation2.value,
      child: SizedBox(
        height: ScreenUtils.h(0.20),
        child: ShaderMask(
          shaderCallback: (Rect rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.transparent,
                Colors.transparent,
                Colors.white,
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
          child: ListView(
            controller: _controller,
            children: [
              MediumText(
                text: product.description,
                size: ScreenUtils.w(0.04),
                color: LifestyleColors.black.withOpacity(0.5),
                maxLine: showFullText ? null : 7,
                overflow: showFullText ? null : TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildPriceAndActionButtonRow(
      ProductDetailsFunctions productDetailsFunctions) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: ScreenUtils.h(0.02),
      ),
      child: SizedBox(
        height: ScreenUtils.h(0.07),
        width: ScreenUtils.w(0.90),
        child: TweenAnimationBuilder<double>(
          curve: Curves.easeIn,
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(seconds: 2),
          builder: (_, value, child) {
            return Opacity(
              opacity: value,
              child: child,
            );
          },
          child: Transform.translate(
            offset: _animation4.value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MediumText(
                      size: ScreenUtils.w(0.04),
                      text: 'Price',
                      color: LifestyleColors.black.withOpacity(0.5),
                    ),
                    MediumText(
                      text: product.price.toString(),
                      size: ScreenUtils.w(0.05),
                    )
                  ],
                ),
                // SizedBox(
                //   width: ScreenUtils.w(0.35),
                // ),
                InkWell(
                  onTap: () {
                    final bouncer = ref.read(bouncerProvider);
                    bouncer.run(() {
                      ref.read(isProcessingProvider.notifier).state = true;
                      productDetailsFunctions.addToCart(product: product);
                    });
                  },
                  child: LifestyleCard(
                      cardColor: LifestyleColors.black,
                      cardChild: Center(
                          child: MediumText(
                        size: ScreenUtils.w(0.04),
                        text: 'ADD TO CART',
                        color: LifestyleColors.white,
                      )),
                      cardWidth: ScreenUtils.w(0.4)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildProductImage() {
    return SizedBox(
      height: ScreenUtils.h(0.40),
      width: ScreenUtils.w(0.80),
      child: TweenAnimationBuilder<double>(
        curve: Curves.easeInSine,
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(seconds: 1),
        builder: (_, value, child) {
          return Opacity(
            opacity: value,
            child: child,
          );
        },
        child: Transform.translate(
          offset: _animation3.value,
          child: ParallaxImageCard(
            isAsset: false,
            useTopGradient: false,
            middleColor: LifestyleColors.productBackground,
            imageUrl: product.images[0],
          ),
        ),
      ),
    );
  }
}

//     final bool showFullText = ref.watch(showFullTextProvider);


  // InkWell(
//                     onTap: () => ref
//                         .watch(showFullTextProvider.notifier)
//                         .update((state) => state = !showFullText),
//                     child: ShowMoreShowLessButton(showFullText: showFullText),
//                   ),


// class ProductDetailsScreen extends ConsumerStatefulWidget {
//   const ProductDetailsScreen({Key? key}) : super(key: key);

//   @override
//   ConsumerState<ProductDetailsScreen> createState() =>
//       _ProductDetailsScreenState();
// }

// class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
//   final Product product = x.Get.arguments;

//   @override
//   void didChangeDependencies() {
//     ref.invalidate(isProcessingProvider);
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isProcessing = ref.watch(isProcessingProvider);
//     final bool showFullText = ref.watch(showFullTextProvider);
//     final ProductDetailsFunctions productDetailsFunction =
//         ref.watch(productDetailsFunctionProvider);
//     return Scaffold(
//       appBar: AppBar(
//           elevation: 0,
//           title: MediumText(
//             font: comorant,
//             text: product.name,
//             size: 17.sp,
//             color: Colors.white,
//           ),
//           backgroundColor: Colors.black),
//       backgroundColor: const Color(0xFFB0A291),
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(),
//             child: SafeArea(
//               child: Column(
//                 children: [
//                   Stack(
//                     children: [
//                       ProductImage(product: product),
//                       ThreeDViewButton(ref: ref, product: product),
//                     ],
//                   ),
//                   ProductNameAndPrice(product: product, ref: ref),
//                   SizedBox(
//                     height: 2.h,
//                   ),
//                   ProductDescriptionWidget(
//                       product: product, showFullText: showFullText),
//                   InkWell(
//                     onTap: () => ref
//                         .watch(showFullTextProvider.notifier)
//                         .update((state) => state = !showFullText),
//                     child: ShowMoreShowLessButton(showFullText: showFullText),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       final bouncer = ref.read(bouncerProvider);
//                       bouncer.run(() {
//                         ref.read(isProcessingProvider.notifier).state = true;
//                         productDetailsFunction.addToCart(product: product);
//                       });
//                     },
//                     child: const AddToCartButton(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           isProcessing ? const ProcessingIndicator() : const Text('')
//           // const ProcessingIndicator()
//         ],
//       ),
//     );
//   }
// }
