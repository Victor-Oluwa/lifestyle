import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/components/admin/update-products/functions/update_product_fuction.dart';

final updateProductImageProvider = StateProvider((ref) => <File>[]);

final updateProductModelProvider = StateProvider((ref) => <File>[]);

final updateProductFunctionProvider =
    Provider((ref) => UpdateProductFunction(ref: ref));

final updateProductCategoryProvider = StateProvider((ref) {
  return ref.read(updateProductFunctionProvider).productCategories[0];
});

final updateProductStatusProvider = StateProvider((ref) {
  return ref.read(updateProductFunctionProvider).statusOptions[0];
});
