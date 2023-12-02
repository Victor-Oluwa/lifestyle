// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lifestyle/Common/widgets/utils.dart';
import 'package:lifestyle/components/user/cart/widgets/quantity_picker.dart';
import 'package:lifestyle/core/bouncer/provider/bouncer_provider.dart';
import 'package:lifestyle/core/connectivity/provider/connectivity_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/Common/widgets/cache_image.dart';
import 'package:lifestyle/components/user/cart/functions/cart_functions.dart';
import 'package:lifestyle/models-classes/cart.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';

import '../../../../../models-classes/product.dart';
import '../../../../Common/widgets/medium_text.dart';

class CartItemWidget extends ConsumerStatefulWidget {
  final Cart cart;
  final BuildContext context;

  const CartItemWidget({
    super.key,
    required this.cart,
    required this.context,
  });

  @override
  ConsumerState<CartItemWidget> createState() => _CartItemState();
}

class _CartItemState extends ConsumerState<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    final cartFunctions = ref.read(cartFunctionProvider);
    final product = widget.cart.product;
    final quantity = widget.cart.quantity;
    return Column(
      children: [
        buildItemWidget(product, cartFunctions, quantity),
      ],
    );
  }

  Container buildItemWidget(
    Product product,
    CartFunctions cartFunction,
    quantity,
  ) {
    return Container(
      padding: EdgeInsets.only(left: 3.w, top: 1.h, bottom: 1.h),
      color: LifestyleColors.kTaupeDark,
      margin: EdgeInsets.symmetric(horizontal: 2.5.h, vertical: 2.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildCartImage(product),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildCartDetails(product),
              Container(
                margin: EdgeInsets.only(top: 0.5.h),
                padding: EdgeInsets.only(left: 2.w),
                width: 60.w,
                child: buildCartButtons(cartFunction, product, quantity),
              )
            ],
          ),
        ],
      ),
    );
  }

  Row buildCartButtons(
    CartFunctions cartFunction,
    Product product,
    quantity,
  ) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildSettingsButton(
          cartFunctions: cartFunction,
          quantity: quantity,
          product: product,
        ),
        SizedBox(
          width: 3.w,
        ),
        buildCartQuantityText(quantity),
        SizedBox(
          width: 3.w,
        ),
        // buildQuantityDecreaseBtn(cartFunction, product),
        SizedBox(
          width: 25.w,
        ),
        cartButtons(cartFunction, product),
      ],
    );
  }

  InkWell cartButtons(
    CartFunctions cartFunction,
    Product product,
  ) {
    return InkWell(
      onTap: () {
        final bouncer = ref.read(bouncerProvider);
        bouncer.run(() {
          cartFunction.deleteCartItem(product);
        });
      },
      child: Padding(
        padding: EdgeInsets.only(top: 1.h),
        child: Icon(
          Icons.delete,
          size: 18.sp,
          color: Colors.white,
        ),
      ),
    );
  }

  MediumText buildCartQuantityText(quantity) {
    return MediumText(
      font: 'Cera',
      color: Colors.white,
      text: '$quantity',
      size: 18.sp,
    );
  }

  InkWell buildSettingsButton(
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

  Column buildCartDetails(Product product) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 2.w),
          // width: 40.w,
          width: 60.w,
          child: MediumText(
            font: comorant,
            text: product.name,
            color: Colors.white,
            size: 16.sp,
          ),
        ),
        Container(
          // color: Colors.brown,
          padding: EdgeInsets.only(left: 2.w),
          // width: 40.w,
          width: 60.w,
          child: MediumText(
            color: Colors.white,
            maxLine: 1,
            text: 'N${product.price}',
            size: 16.sp,
          ),
        ),
      ],
    );
  }

  SizedBox buildCartImage(Product product) {
    return SizedBox(
      height: 13.h,
      width: 13.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.sp),
        child: cacheImage(product.images[0]),
      ),
    );
  }
}
