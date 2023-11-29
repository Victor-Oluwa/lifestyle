import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/models-classes/product.dart';
import 'package:lifestyle/routes-management/lifestyle_routes_names.dart';
import 'package:get/get.dart' as x;

import '../../../../../state/providers/actions/provider_operations.dart';

class ProductDetailsFunctions {
  final Ref ref;
  ProductDetailsFunctions({required this.ref});

  bool _isExpanded = false;
  bool showFullText = false;

  String addCommas(String price) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    matchFunc(Match match) => '${match[1]},';
    return price.replaceAllMapped(reg, matchFunc);
  }

  void decreaseQuantity(Product product) {
    final cartServices = ref.read(cartServicesProvider);
    cartServices.minusCartQuantity(product: product);
  }

  navigateToModelScreen(data) {
    x.Get.toNamed(LifestyleRouteName.modelRoute, arguments: data);
  }

  get toggleExpanded {
    _isExpanded = !_isExpanded;
  }

  void addToCart({required Product product}) {
    ref.read(cartFunctionProvider).addToCart(product);
  }
}