import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/core/bouncer/provider/bouncer_provider.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Common/widgets/medium_text.dart';
import '../../../../../models-classes/product.dart';

class SearchedResultTemplate extends ConsumerStatefulWidget {
  final Product product;
  const SearchedResultTemplate({super.key, required this.product});

  @override
  ConsumerState<SearchedResultTemplate> createState() =>
      _SearchedProductsTemplateState();
}

class _SearchedProductsTemplateState
    extends ConsumerState<SearchedResultTemplate> {
  void addTocart(Product product) {
    final cartServices = ref.read(cartServicesProvider);

    cartServices.addToCart(product: product);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.5.h, vertical: 2.5.h),
      child: Row(
        children: [
          Container(
            height: 17.h,
            width: 17.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.sp),
              color: Colors.transparent,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(widget.product.images[0]),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: Colors.brown,
                padding: EdgeInsets.only(left: 4.w),
                width: 40.w,
                child: MediumText(
                  font: comorant,
                  color: Colors.white,
                  text: widget.product.name,
                  size: 15.sp,
                ),
              ),
              Container(
                // color: Colors.brown,
                margin: EdgeInsets.only(top: 0.5.h),

                padding: EdgeInsets.only(left: 4.w),
                width: 40.w,
                child: MediumText(
                  font: comorant,
                  color: Colors.white,
                  maxLine: 1,
                  text: 'N${widget.product.price}',
                  size: 15.sp,
                ),
              ),
              Container(
                // color: Colors.brown,
                margin: EdgeInsets.only(top: 0.5.h),

                padding: EdgeInsets.only(left: 4.w),
                width: 40.w,
                child: MediumText(
                  color: Colors.white,
                  font: comorant,
                  maxLine: 1,
                  text: '${widget.product.description}..'.trim(),
                  size: 15.sp,
                ),
              ),
              Container(
                // color: Colors.brown,
                margin: EdgeInsets.only(top: 0.5.h),

                padding: EdgeInsets.only(left: 4.w),
                width: 40.w,
                child: MediumText(
                  color: Colors.white,
                  font: comorant,
                  maxLine: 1,
                  text: widget.product.inStock > 0
                      ? '${widget.product.inStock} pieces available'.trim()
                      : 'Out Of Stock',
                  size: 15.sp,
                ),
              ),
              GestureDetector(
                onTap: () {
                  final bouncer = ref.read(bouncerProvider);
                  bouncer.run(() {
                    addTocart(widget.product);
                  }, delay: const Duration(seconds: 3));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 21.w,
                  height: 3.h,
                  padding: EdgeInsets.all(5.sp),
                  margin: EdgeInsets.only(left: 4.w, top: 1.h),
                  color: Colors.black,
                  child: MediumText(
                    font: comorant,
                    text: 'ADD TO CART',
                    size: 12.sp,
                    color: const Color(0xFFB0A291),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
