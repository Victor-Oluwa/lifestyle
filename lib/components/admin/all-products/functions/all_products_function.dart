import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lifestyle/core/error/widgets/empty_screen_widget.dart';
import 'package:lifestyle/core/error/widgets/no_internet_widget.dart';
import 'package:lifestyle/models-classes/product.dart';
import 'package:lifestyle/routes-management/lifestyle_routes_names.dart';

import '../../../../Common/widgets/loading_indicator.dart';
import '../../../../core/connectivity/provider/connectivity_provider.dart';
import '../../../../core/error/widgets/error_message_widget.dart';
import '../../../../state/providers/actions/provider_operations.dart';
import '../../update-products/provider/update_product_provider.dart';
import '../widget/all_products_listview.dart';

class AllProductFunctions {
  final Ref ref;
  AllProductFunctions({required this.ref});

  logOut() {
    final profileServices = ref.read(profileServicesProvider);
    profileServices.logOut();
  }

  Future<Product> deleteProduct(Product product) async {
    final allProductsServices = ref.read(allProductsProvider);
    final String stringResponse = await allProductsServices.deleteProduct(
      product: product,
    );
    log('Deleted product string res: $stringResponse');
    final Product productResponse = jsonDecode(stringResponse);

    return productResponse;
  }

  Future<List<Product>> fetchAllProduct() async {
    final allProductsServices = ref.read(allProductsProvider);
    return await allProductsServices.fetchAllProduct();
  }

  navigateToAddProduct() {
    Get.toNamed(LifestyleRouteName.addProductRoute);
  }

  navigateToUpdateProduct(Product product) {
    ref.read(updateProductCategoryProvider.notifier).state = product.category;
    ref.read(updateProductStatusProvider.notifier).state = product.status;

    Get.toNamed(LifestyleRouteName.updateProductRoute, arguments: product);
  }

  List<bool> isSelected = [false, false];

  checkInternetConnection() async {
    final connectivity = ref.read(connectivityServiceProvider);
    final connectionState = await connectivity.checkInternetConnection();
    ref.read(isConnected.notifier).state = connectionState;
  }

  Widget buildAllProductView(
      {required AllProductFunctions allProductsFunction,
      required WidgetRef ref}) {
    checkInternetConnection();
    final connected = ref.watch(isConnected);
    return buildView(
        ref: ref,
        allProductsFunction: allProductsFunction,
        internet: connected);
  }

  Widget buildView({
    required AllProductFunctions allProductsFunction,
    required WidgetRef ref,
    required bool internet,
  }) {
    if (internet) {
      return ref.watch(fetchAllProductsProvider).when(
        data: (List<Product> product) {
          final emptyProduct = product.isEmpty || product == [];
          switch (emptyProduct) {
            case false:
              return SafeArea(
                child: AllProductsListView(
                  ref: ref,
                  products: product,
                ),
              );
            case true:
              return const EmptyScreenWidget();
            default:
              return const EmptyScreenWidget();
          }
        },
        error: (e, s) {
          return const ErrorMessageWidget(errorMessage: 'Something went wrong');
        },
        loading: () {
          return const LoadingIndicator();
        },
      );
    } else {
      return NoInternetWidget(onRefresh: () {
        checkInternetConnection();
      });
    }
  }

  // List<Product>? products;
}
