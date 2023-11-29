import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lifestyle/Common/widgets/utils.dart';
import 'package:lifestyle/core/connectivity/provider/connectivity_provider.dart';
import 'package:lifestyle/core/error/widgets/no_internet_widget.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:lifestyle/models-classes/product.dart';
import 'package:lifestyle/routes-management/lifestyle_routes_names.dart';

import '../../../../Common/widgets/loading_indicator.dart';
import '../../../../core/error/widgets/empty_screen_widget.dart';
import '../provider/search_provider.dart';
import '../services/search_services.dart';
import '../widget/search_result_widget.dart';

class SearchFunction {
  final Ref ref;
  SearchFunction({required this.ref});

  void setQueryValue({required String query}) {
    ref.watch(queryProvider.notifier).update((state) => query);
  }

  navigateToProductDetailsScreen(product) {
    Get.toNamed(LifestyleRouteName.productDetailRoute, arguments: product);
  }

  Future<List<Product>> fetchSearchedProducts({required String query}) async {
    final SearchServices searchServices = ref.read(searchServicesProvider);
    List<Product> products = [];
    if (query != '') {
      products =
          await searchServices.fetchSearchedProduct(searchQuery: query.trim());
      log(products.length.toString());
    } else if (query == '') {
    } else {
      dropperMessage('ERROR', 'Failed to fetch product');
    }
    return products;
  }

  Future<void> checkConnection() async {
    final connectivity = ref.watch(connectivityServiceProvider);
    final status = await connectivity.checkInternetConnection();
    ref.watch(isConnected.notifier).update((state) => status);
  }

  Widget buildSearchView({
    required WidgetRef ref,
    required String query,
    required TextEditingController controller,
  }) {
    checkConnection();
    final connected = ref.watch(isConnected);

    return buildView(
      ref: ref,
      query: query,
      internet: connected,
      controller: controller,
    );
  }

  Widget buildView({
    required WidgetRef ref,
    required String query,
    required bool internet,
    required TextEditingController controller,
  }) {
    if (internet) {
      return ref.watch(searchResultProvider(query)).when(
        data: (data) {
          if (data.isEmpty || data == []) {
            return const EmptyScreenWidget();
          } else {
            return SearchResultWidget(
              controller: controller,
              ref: ref,
              data: data,
            );
          }
        },
        error: (e, s) {
          return const EmptyScreenWidget();
        },
        loading: () {
          return const LoadingIndicator();
        },
      );
    } else {
      return NoInternetWidget(
        onRefresh: () {
          log('message');
          checkConnection();
        },
      );
    }
  }
}
