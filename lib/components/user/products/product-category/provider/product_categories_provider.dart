import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/components/user/products/product-category/function/product_category_function.dart';

final productCategoriesFunctionProvider =
    Provider((ref) => ProductCategoryFuction(ref: ref));

final getCategoryProductProvider =
    FutureProvider.autoDispose.family((ref, String category) async {
  ref.keepAlive();
  return await ref
      .watch(productCategoriesFunctionProvider)
      .fetchCategoryProducts(category: category);
});
