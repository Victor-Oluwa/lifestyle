import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lifestyle/Common/widgets/lifestyle_card.dart';
import 'package:lifestyle/components/user/products/product-category/widgets/parallax_image_card.dart';
import 'package:lifestyle/core/utils/screen_utils.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/Common/widgets/medium_text.dart';

import '../../../../Common/colors/lifestyle_colors.dart';
import '../../../../Common/fonts/lifestyle_fonts.dart';

class CartViewScreen extends ConsumerStatefulWidget {
  const CartViewScreen({super.key});

  @override
  ConsumerState<CartViewScreen> createState() => _CartViewScreen();
}

class _CartViewScreen extends ConsumerState<CartViewScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController addressController;
  late TextEditingController phoneController;

  late AnimationController _animationController;
  late Animation<Offset> _animation1;
  late Animation<Offset> _animation2;
  late Animation<double> _animation3;
  late Animation<Offset> _animation4;

  @override
  void initState() {
    addressController = TextEditingController();
    phoneController = TextEditingController();

    final paystackFunction = ref.read(paystackFunctionsProvider);
    paystackFunction.startPaystark();
    final cartFunction = ref.read(cartFunctionProvider);
    cartFunction.syncUserCart();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    ref.invalidate(isProcessingProvider);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation1 = Tween<Offset>(
      begin: Offset(-MediaQuery.of(context).size.width, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<Offset>(
      begin: Offset(MediaQuery.of(context).size.width, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ))
      ..addListener(() {
        setState(() {});
      });

    _animation3 = Tween<double>(
      begin: 0.0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ))
      ..addListener(() {
        setState(() {});
      });

    _animation4 = Tween<Offset>(
      begin: Offset(0.0, MediaQuery.of(context).size.width),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ))
      ..addListener(() {
        setState(() {});
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    addressController.dispose();
    phoneController.dispose();
    _animationController.removeListener(() {
      setState(() {});
    });
    _animationController.dispose();
    super.dispose();
  }

  Animation<double> get _interval1 => CurvedAnimation(
        parent: _animation3,
        curve: const Interval(0.4, 1, curve: Curves.easeOut),
      );

  Animation<double> get _interval2 => CurvedAnimation(
        parent: _animation3,
        curve: const Interval(0.6, 1, curve: Curves.easeOut),
      );

  Animation<double> get _interval3 => CurvedAnimation(
        parent: _animation3,
        curve: const Interval(0.8, 1, curve: Curves.easeOut),
      );

  @override
  Widget build(BuildContext context) {
    final cartFunction = ref.watch(cartFunctionProvider);
    final cartList = cartFunction.getUserCartList();
    final isProcessing = ref.watch(isProcessingProvider);

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 10.h,
          elevation: 0,
          scrolledUnderElevation: 0.0,
          backgroundColor: LifestyleColors.kTaupeBackground,
          leading: Transform.translate(
            offset: _animation1.value,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_sharp,
                color: LifestyleColors.black,
              ),
            ),
          ),
          title: Transform.translate(
            offset: _animation1.value,
            child: MediumText(
              text: 'CART',
              color: LifestyleColors.black,
              size: ScreenUtils.w(0.06),
            ),
          ),
        ),
        backgroundColor: LifestyleColors.kTaupeBackground,
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: ScreenUtils.h(0.28),
                  // color: LifestyleColors.black,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: ScreenUtils.h(0.03),
                        right: ScreenUtils.h(0.03),
                        bottom: ScreenUtils.h(0.02)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Transform.translate(
                              offset: _animation1.value,
                              child: MediumText(
                                text: 'Subtotal:',
                                color: LifestyleColors.black.withOpacity(0.5),
                              ),
                            ),
                            Transform.translate(
                                offset: _animation2.value,
                                child: MediumText(
                                    color: LifestyleColors.black,
                                    text: '₦${cartFunction.getSumWithComma()}'))
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Transform.translate(
                              offset: _animation1.value,
                              child: MediumText(
                                text: 'Delivery:',
                                color: LifestyleColors.black.withOpacity(0.5),
                              ),
                            ),
                            Transform.translate(
                                offset: _animation2.value,
                                child: const MediumText(
                                    color: LifestyleColors.black, text: '₦0.0'))
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Transform.translate(
                                offset: _animation1.value,
                                child: const MediumText(
                                    color: LifestyleColors.black,
                                    text: 'Total:')),
                            Transform.translate(
                                offset: _animation2.value,
                                child: MediumText(
                                    color: LifestyleColors.black,
                                    size: 18.sp,
                                    text: '₦${cartFunction.getSumWithComma()}'))
                          ],
                        ),
                        SizedBox(height: 4.h),
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration: Duration(seconds: 2),
                          curve: Curves.easeOut,
                          builder: (_, value, child) {
                            return Opacity(
                              opacity: value,
                              child: child,
                            );
                          },
                          child: Transform.translate(
                            offset: _animation4.value,
                            child: LifestyleCard(
                              cardColor: LifestyleColors.black,
                              cardChild: Container(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                alignment: Alignment.center,
                                child: MediumText(
                                  text: 'PROCEED',
                                  color: LifestyleColors.productBackground,
                                  size: 18.sp,
                                ),
                              ),
                              cardWidth: 90.w,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: ScreenUtils.h(0.60),
                  width: ScreenUtils.w(0.95),
                  child: ShaderMask(
                    shaderCallback: (Rect rect) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          LifestyleColors.kTaupeBackground,
                          Colors.transparent,
                          Colors.transparent,
                          LifestyleColors.kTaupeBackground
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
                    child: AnimatedList(
                        initialItemCount: cartList.length,
                        itemBuilder: (context, index, animation) {
                          final cart = cartList[index];
                          return SlideTransition(
                            position: Tween(
                              begin: const Offset(0, 2),
                              end: Offset.zero,
                            ).animate(index == 0
                                ? _interval1
                                : index == 1
                                    ? _interval2
                                    : index == 2
                                        ? _animation3
                                        : _interval3),
                            child: FadeTransition(
                              opacity: index == 0
                                  ? _interval1
                                  : index == 1
                                      ? _interval2
                                      : index == 2
                                          ? _animation3
                                          : _interval3,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border(
                                          bottom: BorderSide(
                                              color: LifestyleColors.black
                                                  .withOpacity(0.3)),
                                          top: index == 0
                                              ? BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.2))
                                              : BorderSide.none),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.h),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 15.h,
                                          width: 30.w,
                                          child: ParallaxImageCard(
                                              parallaxValue: 0.0,
                                              isAsset: false,
                                              middleColor: LifestyleColors
                                                  .productBackground,
                                              useTopGradient: false,
                                              imageUrl: cart.product.images[0]),
                                        ),
                                        SizedBox(width: 4.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            MediumText(
                                              color: LifestyleColors.black,
                                              text: cart.product.name,
                                              size: 17.sp,
                                            ),
                                            MediumText(
                                              text: 'QUANTITY',
                                              size: 14.sp,
                                              color: LifestyleColors.black
                                                  .withOpacity(0.5),
                                            ),
                                            SvgPicture.asset(
                                              'assets/seek.svg',
                                              height: 4.0.h,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(height: 2.h),
                                            MediumText(
                                              color: LifestyleColors.black,
                                              text: cartFunction
                                                  .getProductPriceWithCommas(
                                                      '₦${cart.product.price}'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 3.2.h, right: 3.w),
                                    child: Align(
                                        alignment: Alignment.topRight,
                                        child: SvgPicture.asset(
                                          'assets/cancel.svg',
                                          height: 3.0.h,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              )
              // cartFunction.buildCartView(
              //     cart: cart, cartFunction: cartFunction, ref: ref),
              // isProcessing ? const ProcessingIndicator() : const Text('')
            ],
          ),
        ));
  }
}

/*
Widget buildSettingsButton(
      {required CartFunctions cartFunctions,
      required Product product,
      required int quantity}) {
    return InkWell(
      onTap: () {
        ref.read(isProcessingProvider.notifier).state = true;

        final internet = ref.read(isConnected);
        internet == true
            ? ref
                .watch(cartFunctionProvider)
                .getProductQuantity(product.id)
                .then((maxValue) {
                ref.invalidate(isProcessingProvider);
                showDialog(
                    barrierDismissible: false,
                    barrierColor: LifestyleColors.black.withOpacity(0.8),
                    context: widget.context,
                    builder: (context) {
                      return QuantityPicker(
                          ref: ref,
                          product: product,
                          cartFunctions: cartFunctions,
                          maxValue: maxValue > -1 ? maxValue : 0);
                    });
              })
            : showBottomSnackBar(
                message: 'Connect to the internet and try again',
                title: 'No Internet Connection');
      },
      child: Container(
        decoration: const BoxDecoration(),
        child: Align(
            alignment: Alignment.centerLeft,
            child: SvgPicture.asset(
              'assets/Settings2.svg',
              height: 3.0.h,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
 */