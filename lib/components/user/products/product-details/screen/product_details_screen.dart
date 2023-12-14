import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/Common/widgets/processing_indicator.dart';
import 'package:lifestyle/components/user/products/product-details/functions/product_details_functions.dart';
import 'package:lifestyle/components/user/products/product-details/widgets/add_to_cart_button.dart';
import 'package:lifestyle/components/user/products/product-details/widgets/product_description_widget.dart';
import 'package:lifestyle/components/user/products/product-details/widgets/product_image.dart';
import 'package:lifestyle/components/user/products/product-details/widgets/product_name_and_price_widget.dart';
import 'package:lifestyle/components/user/products/product-details/widgets/showmore_showless_button.dart';
import 'package:lifestyle/components/user/products/product-details/widgets/three_d_view_button.dart';
import 'package:lifestyle/models-classes/product.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart' as x;
import '../../../../../Common/widgets/medium_text.dart';
import '../../../../../core/bouncer/provider/bouncer_provider.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  final Product product = x.Get.arguments;

  @override
  void didChangeDependencies() {
    ref.invalidate(isProcessingProvider);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final isProcessing = ref.watch(isProcessingProvider);
    final bool showFullText = ref.watch(showFullTextProvider);
    final ProductDetailsFunctions productDetailsFunction =
        ref.watch(productDetailsFunctionProvider);
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: MediumText(
            font: comorant,
            text: product.name,
            size: 17.sp,
            color: Colors.white,
          ),
          backgroundColor: Colors.black),
      backgroundColor: const Color(0xFFB0A291),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(),
            child: SafeArea(
              child: Column(
                children: [
                  Stack(
                    children: [
                      ProductImage(product: product),
                      ThreeDViewButton(ref: ref, product: product),
                    ],
                  ),
                  ProductNameAndPrice(product: product, ref: ref),
                  SizedBox(
                    height: 2.h,
                  ),
                  ProductDescriptionWidget(
                      product: product, showFullText: showFullText),
                  InkWell(
                    onTap: () => ref
                        .watch(showFullTextProvider.notifier)
                        .update((state) => state = !showFullText),
                    child: ShowMoreShowLessButton(showFullText: showFullText),
                  ),
                  InkWell(
                    onTap: () {
                      final bouncer = ref.read(bouncerProvider);
                      bouncer.run(() {
                        ref.read(isProcessingProvider.notifier).state = true;
                        productDetailsFunction.addToCart(product: product);
                      });
                    },
                    child: const AddToCartButton(),
                  ),
                ],
              ),
            ),
          ),
          isProcessing ? const ProcessingIndicator() : const Text('')
          // const ProcessingIndicator()
        ],
      ),
    );
  }
}
