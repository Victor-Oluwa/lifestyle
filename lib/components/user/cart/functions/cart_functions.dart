import 'dart:developer';

import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/widgets/utils.dart';
import 'package:lifestyle/core/error/widgets/empty_screen_widget.dart';
import 'package:lifestyle/core/error/widgets/no_internet_widget.dart';
import 'package:lifestyle/models-classes/cart.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:lifestyle/state/providers/provider_model/user_provider.dart';
import 'package:lifestyle/routes-management/lifestyle_routes_names.dart';
import 'package:lifestyle/models-classes/product.dart';
import 'package:get/get.dart' as x;

import '../../../../core/connectivity/provider/connectivity_provider.dart';
import '../../../../models-classes/user.dart';
import '../widgets/total_price_bar.dart';
import '../widgets/cart_listview.dart';
import '../widgets/proceed_button.dart';

class CartFunctions {
  final Ref ref;
  CartFunctions({required this.ref});

  Future<int> getProductQuantity(productId) async {
    final cartService = ref.read(cartServicesProvider);
    return await cartService.getProductQuantity(productId: productId);
  }

  Future<void> updateCartItemQuantity(
      {required String productId, required int quantity}) async {
    final cartServices = ref.read(cartServicesProvider);

    await cartServices.updateCartItemQuantity(
        productId: productId, quantity: quantity);
  }

  void deleteCartItem(Product product) {
    ref.read(isProcessingProvider.notifier).state = true;
    final cartServices = ref.read(cartServicesProvider);
    cartServices.deleteFromCart(product: product);
  }

  void navigateToOrderDetailsScreen() {
    x.Get.toNamed(LifestyleRouteName.deliveryDetails);
  }

  Future<void> approveOrder({required String orderId}) async {
    final cartServices = ref.read(cartServicesProvider);
    return await cartServices.approveOrder(orderId: orderId);
  }

  void addToCart(Product product) async {
    final cartServices = ref.read(cartServicesProvider);
    final connectionChecker = ref.read(connectivityServiceProvider);
    await connectionChecker.checkInternetConnection().then((connected) async {
      if (connected) {
        await cartServices.addToCart(product: product);
      } else {
        ref.invalidate(isProcessingProvider);
        showBottomSnackBar(
            message: 'Connect to the internet and try again',
            title: 'No Internet');
      }
    });
  }

  Future<User> saveUserBillingDetails(
      {required String address, required String phone}) async {
    final cartServices = ref.read(cartServicesProvider);
    return await cartServices.saveUserBillingDetails(
        address: address, phone: phone);
  }

  List<Cart> getUserCartList() {
    final user = ref.watch(userProvider);
    return user.cart.map((cart) => Cart.fromMap(cart)).toList();
  }

  Future<void> syncUserCart() async {
    final cartServices = ref.read(cartServicesProvider);
    await cartServices.syncCart();
  }

  checkInternetConnection() async {
    final connectivityService = ref.watch(connectivityServiceProvider);
    final connectionState = await connectivityService.checkInternetConnection();

    ref.read(isConnected.notifier).state = connectionState;
  }

  buildCartView({
    required List<Cart> cart,
    required CartFunctions cartFunction,
    required WidgetRef ref,
  }) {
    checkInternetConnection();
    final connected = ref.watch(isConnected);
    log('Connection is available: $connected');

    return buildView(
      cart: cart,
      cartFunction: cartFunction,
      ref: ref,
      internet: connected,
    );
  }

  Widget buildView({
    required List<Cart> cart,
    required CartFunctions cartFunction,
    required WidgetRef ref,
    required bool internet,
  }) {
    if (internet) {
      final bool cartIsEmpty = cart.isEmpty;
      switch (cartIsEmpty) {
        case true:
          return const EmptyScreenWidget();
        case false:
          return Column(
            children: [
              const TotalPriceBar(),
              CartListView(
                cart: cart,
                ref: ref,
              ),
              CartProceedButton(
                cartFunctions: cartFunction,
              ),
            ],
          );
        default:
          return const EmptyScreenWidget();
      }
    } else {
      return NoInternetWidget(
        buttonText: '',
        onRefresh: () {
          log('message');
          checkInternetConnection();
        },
      );
    }
  }

  String addCommas(String price) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    matchFunc(Match match) => '${match[1]},';
    return price.replaceAllMapped(reg, matchFunc);
  }

  String getSum() {
    double sum = 0;
    final userCart = getUserCartList();
    for (var cart in userCart) {
      sum += cart.product.price * cart.quantity;
    }
    log('Cart Sum: $sum');
    return sum.round().toString();

    // final user = ref.read(userProvider);
    // for (var cart in user.cart) {
    //   sum += cart['quantity'] * cart['product']['price'];
    // }
  }

  String getProductPriceWithCommas(String price) {
    return addCommas(price);
  }

  String getSumWithComma() {
    double sum = 0;
    final userCart = getUserCartList();
    for (var cart in userCart) {
      sum += cart.product.price * cart.quantity;
    }
    final sumWithComma = addCommas(sum.toString());
    log('Cart Sum: $sum');
    return sumWithComma;
  }
}
