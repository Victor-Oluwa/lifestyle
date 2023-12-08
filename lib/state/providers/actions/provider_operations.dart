import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/components/admin/all-products/functions/all_products_function.dart';
import 'package:lifestyle/components/admin/orders/services/order_services.dart';
import 'package:lifestyle/components/admin/sales-analysis/services/sales_analysis_services.dart';
import 'package:lifestyle/components/user/auth/services/auth_services.dart';
import 'package:lifestyle/components/user/home/functions/home_function.dart';
import 'package:lifestyle/components/user/products/product-details/functions/product_details_functions.dart';
import 'package:lifestyle/components/user/payment/paystack/services/paystack_services.dart';
import 'package:lifestyle/components/user/cart/functions/cart_functions.dart';

import 'package:lifestyle/components/admin/add_product/function/add_product_functions.dart';
import 'package:lifestyle/components/admin/order-details/function/order_details_function.dart';
import 'package:lifestyle/components/user/profile/function/profile_functions.dart';
import 'package:lifestyle/state/providers/provider_model/user_provider.dart';
import 'package:tuple/tuple.dart';

import '../../../components/admin/add_product/services/add_products_services.dart';
import '../../../components/admin/all-products/services/all_products_services.dart';
import '../../../components/admin/order-details/services/order_details_services.dart';
import '../../../components/admin/update-products/services/update_product_services.dart';
import '../../../components/user/cart/services/cart_services.dart';
import '../../../components/user/notification/function/notification_function.dart';
import '../../../components/user/notification/services/notification_services.dart';
import '../../../components/admin/orders/functions/order_functions.dart';
import '../../../components/user/payment/paystack/function/paystack_functions.dart';
import '../../../components/user/profile/services/profile_services.dart';
import '../../../components/user/search/function/search_function.dart';
import '../../../components/user/search/services/search_services.dart';

final authServiceProvider = Provider((ref) => AuthServices(ref: ref));
final profileServicesProvider =
    Provider.autoDispose((ref) => ProfileServices(ref: ref));
final searchServicesProvider =
    Provider.autoDispose((ref) => SearchServices(ref: ref));
final notificationServicesProvider = Provider((ref) => NotificationServices(
    ref: ref, firebaseMessaging: FirebaseMessaging.instance));
final notificationFunctionProvider = Provider((ref) => NotificationFunction(
    ref: ref, firebaseMessaging: FirebaseMessaging.instance));
final orderDetailsFunctionProvider =
    Provider.autoDispose((ref) => OrderDetailsFunctions(ref: ref));
final allProductsFunctionProvider =
    Provider((ref) => AllProductFunctions(ref: ref));
final orderServicesProvider = Provider((ref) => OrderServices(ref));
final addProductServicesProvider = Provider((ref) =>
    AddProductServices(ref: ref, firebaseStorage: FirebaseStorage.instance));
final addProductFunctionProvider =
    Provider((ref) => AddProductFunctions(ref: ref));
final cartFunctionProvider = Provider((ref) => CartFunctions(ref: ref));
final paystackFunctionsProvider =
    Provider.autoDispose((ref) => PaystackFunctions(ref: ref));
final paystackServicesProvider =
    Provider.autoDispose((ref) => PaystackServices(ref: ref));
final cartServicesProvider =
    Provider.autoDispose((ref) => CartServices(ref: ref));
final orderFunctionsProvider =
    Provider.autoDispose((ref) => OrderFunctions(ref: ref));
final searchFunctionProvider =
    Provider.autoDispose((ref) => SearchFunction(ref: ref));
final allProductsProvider = Provider((ref) => AllProductsServices(ref: ref));
final homeFunctionProvider =
    Provider.autoDispose((ref) => HomeFunction(ref: ref));
final updateProductsProvider = Provider((ref) =>
    UpdateProductServices(ref: ref, firebaseStorage: FirebaseStorage.instance));
final salesAnalysisProvider =
    Provider((ref) => SalesAnalysisServices(ref: ref));
final orderDetailsProvider = Provider((ref) => OrderDetailsServices(ref: ref));
final showFullTextProvider = StateProvider.autoDispose((ref) {
  final productDetailsFunction = ref.watch(productDetailsFunctionProvider);
  return productDetailsFunction.showFullText;
});
final productDetailsFunctionProvider =
    Provider.autoDispose((ref) => ProductDetailsFunctions(ref: ref));

// final connectivityProvider = FutureProvider((ref) async {
//   final authService = ref.watch(authServiceProvider);
//   return await authService.checkInternetConnection();
// });

final profileFunctionsProvider = Provider((ref) => ProfileFunctions(ref: ref));

// final

final getOrderStatusProvider = FutureProvider.family((ref, Tuple2 arg) async {
  // ref.keepAlive();
  final orderDetailsService = ref.watch(orderDetailsProvider);
  final result = await orderDetailsService.fetchOrderStatus(order: arg.item2);
  return result;
});

//Fetch Orders
final getOrdersFutureProvider = FutureProvider((ref) async {
  return await ref.watch(orderServicesProvider).fetchOrders();
});

final getFailedOrdersFutureProvider = FutureProvider((ref) async {
  return await ref.watch(orderServicesProvider).fetchFailedOrders();
});

final fetchAllProductsProvider = FutureProvider((ref) async {
  final postScreenFunction = ref.watch(allProductsFunctionProvider);
  final allProducts = await postScreenFunction.fetchAllProduct();
  // ref.read(allProductsProvider.notifier).state = allProducts;

  return allProducts;
});

final fcmTokenStateProvider = StateProvider((ref) => '');

final userPictureState = StateProvider((ref) {
  final user = ref.watch(userProvider);
  return user.picture;
});

final fetchOrdersProvider = FutureProvider.autoDispose((ref) async {
  final profileFunctions = ref.watch(profileFunctionsProvider);
  return await profileFunctions.fetchOrders();
});

final isProcessingProvider = StateProvider((ref) => false);


// class ProviderOperation {}
