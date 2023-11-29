// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../models-classes/product.dart';
import '../../widgets/post_screen_product_image.dart.dart';
import '../functions/all_products_function.dart';
import 'products_name_and_delete_button.dart';

class AllProductsListView extends StatelessWidget {
  const AllProductsListView({
    Key? key,
    required this.products,
    required this.ref,
  }) : super(key: key);
  final List<Product> products;
  final WidgetRef ref;
  @override
  Widget build(BuildContext context) {
    final allProductsFunctions = ref.read(allProductsFunctionProvider);
    return Column(
      children: [
        SizedBox(
          height: 1.h,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                cacheExtent: 100,
                crossAxisSpacing: 5,
                itemCount: products.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 4.w, left: 4.w, top: 2.h),
                    child: Column(
                      children: [
                        buildProductsImage(
                          index: index,
                          allProductFunctions: allProductsFunctions,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        buildNameAndDeleteIcon(
                          index: index,
                          allProductFunctions: allProductsFunctions,
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }

  Widget buildNameAndDeleteIcon({
    required int index,
    required AllProductFunctions allProductFunctions,
  }) {
    return NameAndDeleteIcon(
      product: products[index],
      ref: ref,
      index: index,
    );
  }

  GestureDetector buildProductsImage({
    required int index,
    required AllProductFunctions allProductFunctions,
  }) {
    return GestureDetector(
      onTap: () {
        allProductFunctions.navigateToUpdateProduct(products[index]);
      },
      child: ProductImageWidget(
        postScreenFunctoin: allProductFunctions,
        product: products[index],
      ),
    );
  }
}
