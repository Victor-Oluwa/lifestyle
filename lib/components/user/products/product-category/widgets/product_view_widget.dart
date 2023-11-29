import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lifestyle/common/widgets/app_constants.dart';
import 'package:lifestyle/common/widgets/cache_image.dart';
import 'package:lifestyle/common/widgets/medium_text.dart';
import 'package:lifestyle/components/user/products/product-category/provider/product_categories_provider.dart';
import 'package:lifestyle/models-classes/product.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductsGridViewWidget extends ConsumerWidget {
  const ProductsGridViewWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final List<Product> data;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('Main data: $data');
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(const Duration(seconds: 3)).then(
                      (value) => ref.invalidate(getCategoryProductProvider));
                },
                child: MasonryGridView.count(
                  itemCount: data.length,
                  addAutomaticKeepAlives: true,
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
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(7.sp),
                            child: cacheImage(data[index].images[0]),
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
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
