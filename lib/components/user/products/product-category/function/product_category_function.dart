import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lifestyle/components/user/home/services/home_services.dart';
import '../../../../../core/error/widgets/empty_screen_widget.dart';
import '../../../../../core/error/widgets/no_internet_widget.dart';
import '../../../../../Common/widgets/loading_indicator.dart';
import '../../../../../core/connectivity/provider/connectivity_provider.dart';
import '../../../../../models-classes/product.dart';
import '../../../../../routes-management/lifestyle_routes_names.dart';

import '../../../home/provider/home_provider.dart';
import '../provider/product_categories_provider.dart';
import '../widgets/product_view_widget.dart';

class ProductCategoryFuction {
  final Ref ref;
  ProductCategoryFuction({
    required this.ref,
  });

  Future<List<Product>> fetchCategoryProducts(
      {required String category}) async {
    final HomeServices homeServices = ref.read(homeServiceProvider);

    return await homeServices.fetchProductCategory(category: category);
  }

  void goToProductDetailScreen({required Product product}) {
    Get.toNamed(LifestyleRouteName.productDetailRoute, arguments: product);
  }

  checkInternetConnection() async {
    final connectivityService = ref.watch(connectivityServiceProvider);
    final connectionState = await connectivityService.checkInternetConnection();
    ref.watch(isConnected.notifier).state = connectionState;
  }

  Widget buildProductsView({required String category, required WidgetRef ref}) {
    checkInternetConnection();
    final connected = ref.watch(isConnected);
    return buildView(category: category, internet: connected, ref: ref);
  }

  Widget buildView(
      {required String category,
      required bool internet,
      required WidgetRef ref}) {
    if (internet) {
      return Container(
          child: ref.watch(getCategoryProductProvider(category)).when(
        data: (data) {
          final bool emptyData = data.isEmpty;
          switch (emptyData) {
            case true:
              return const EmptyScreenWidget();
            case false:
              return ProductsGridViewWidget(
                data: data,
              );
            default:
              return const EmptyScreenWidget();
          }
        },
        error: (e, s) {
          return const LoadingIndicator();
        },
        loading: () {
          return const LoadingIndicator();
        },
      ));
    } else {
      return NoInternetWidget(onRefresh: () {
        checkInternetConnection();
      });
    }
  }
}
