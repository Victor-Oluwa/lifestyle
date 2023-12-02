import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/Common/widgets/snackbar_messages.dart';
import 'package:lifestyle/common/widgets/utils.dart';
import 'package:lifestyle/components/user/cart/screens/out_of_stock_screen.dart';
import 'package:lifestyle/state/providers/provider_model/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart' as x;
import 'package:lifestyle/core/error/exception/api_exception.dart';

import '../../../../../models-classes/product.dart';
import '../../../../../models-classes/user.dart';
import '../../../../models-classes/order.dart';
import '../../../../state/providers/actions/provider_operations.dart';
import '../../../../state/providers/provider_model/orders_provider.dart';

class CartServices {
  final Ref ref;

  CartServices({required this.ref});

  Future<void> updateCartItemQuantity({
    required String productId,
    required int quantity,
  }) async {
    try {
      final user = ref.read(userProvider);
      final http.Response res = await http.post(
        Uri.parse('$uri/cart/update-quantity'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          AppConstants.authToken: user.token,
        },
        body: jsonEncode({
          'productId': productId,
          'quantity': quantity,
        }),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        final user = User.fromMap(jsonDecode(res.body));
        ref.read(userProvider.notifier).updateCart(cart: user.cart);
      } else {
        throw APIException(message: res.body, statusCode: res.statusCode);
      }
    } on APIException catch (e) {
      log('Failed to update cart quantity: ${e.message}');
    } catch (e) {
      log('Failed to update cart quantity: $e');
    }
    ref.invalidate(isProcessingProvider);
  }

  void minusCartQuantity({
    required Product product,
  }) async {
    final User user = ref.read(userProvider);
    final UserNotifier userNotifier = ref.read(userProvider.notifier);
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          AppConstants.authToken: user.token
        },
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        userNotifier.updateCart(cart: jsonDecode(res.body)['cart']);
        Get.snackbar('DONE', 'Item has been removed');
      } else {
        throw APIException(
          message: res.body,
          statusCode: res.statusCode,
        );
      }
    } on APIException catch (e) {
      dropperMessage(
        kRemoveFromCartErrorMessage['Title'],
        kRemoveFromCartErrorMessage['Body'],
      );
      log('${e.statusCode} Error: ${e.message}');
    } catch (e) {
      log(e.toString());
    }
  }

  void deleteFromCart({
    required Product product,
  }) async {
    final User user = ref.read(userProvider);
    final UserNotifier userNotifier = ref.read(userProvider.notifier);
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/delete-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          AppConstants.authToken: user.token
        },
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        userNotifier.updateCart(cart: jsonDecode(res.body)['cart']);
      } else {
        throw APIException(message: res.body, statusCode: res.statusCode);
      }
    } on APIException catch (e) {
      dropperMessage(
        kDeleteFromCartErrorMessage['Title'],
        kDeleteFromCartErrorMessage['Body'],
      );
      log('${e.statusCode} Error: ${e.message}');
    } catch (e) {
      log(e.toString());
    }
    ref.invalidate(isProcessingProvider);
  }

  Future<void> addToCart({
    required Product product,
  }) async {
    final User user = ref.read(userProvider);
    final userNotifier = ref.read(userProvider.notifier);

    try {
      final response = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          AppConstants.authToken: user.token,
        },
        body: jsonEncode(
          {
            'id': product.id,
          },
        ),
      );

      if (response.statusCode == 200) {
        final resData = jsonDecode(response.body);
        userNotifier.updateCart(cart: resData['cart']);

        x.Get.snackbar('Success', 'Item has been added to your cart');
      } else {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on APIException catch (e) {
      log('APIError Catch ${e.statusCode}');
      if (e.statusCode == 404) {
        dropperMessage(
          'Out Of Stock',
          e.message,
        );
      } else {
        dropperMessage(
          kAddToCartErrorMessage['Title'],
          kAddToCartErrorMessage['Body'],
        );
      }
      log('${e.statusCode} Error: ${e.message}');
    } catch (e) {
      dropperMessage(
        kAddToCartErrorMessage['Title'],
        kAddToCartErrorMessage['Body'],
      );
      log('Add to cart error: $e');
    }
    ref.invalidate(isProcessingProvider);
  }

  Future<Order> placeOrder(
      {required String address, required int totalSum}) async {
    Order result = Order.empty();
    final User user = ref.read(userProvider);

    try {
      http.Response res = await http.post(Uri.parse('$uri/api/order'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            AppConstants.authToken: user.token,
          },
          body: jsonEncode({
            'cart': user.cart,
            'totalPrice': totalSum,
            'address': address,
            'userName': user.name
          }));

      if (res.statusCode == 200) {
        final OrderNotifier userNotifier = ref.read(orderProvider.notifier);
        result = Order.fromMap(jsonDecode(res.body));
        userNotifier.updateOrder(order: res.body);
      } else if (res.statusCode == 404) {
        Get.to(() => const OutOfStockScreen(), arguments: jsonDecode(res.body));
      } else {
        throw APIException(
          message: res.body,
          statusCode: res.statusCode,
        );
      }
    } on APIException catch (e) {
      if (e.statusCode == 400) {
        dropperMessage('Out Of Stock', e.message);
      } else {
        dropperMessage(
          kPlaceOrderErrorMessage['Title'],
          kPlaceOrderErrorMessage['Body'],
        );
      }
      return Order.empty();
    } catch (e) {
      dropperMessage('Failed To Process Order', 'Try again latter');
      // showSnackBar(errorMessageTitle, errorMesssage);
      log('Could not place order: $e');

      return Order.empty();
    }

    return result;
  }

  Future<void> approveOrder({required String orderId}) async {
    final Dio dio = Dio();
    final User user = ref.read(userProvider);
    final UserNotifier notifyUser = ref.read(userProvider.notifier);

    try {
      final res = await dio.post(
        '$uri/order/approve',
        options: Options(
          contentType: Headers.jsonContentType,
        ),
        data: jsonEncode({
          'orderId': orderId,
          'userId': user.id,
        }),
      );
      // log('Recall response: ${res.data}');
      if (res.statusCode == 200 || res.statusCode == 201) {
        ref.invalidate(fetchOrdersProvider);

        notifyUser.updateCart(cart: res.data['cart']);
        dropperMessage('ATTENTION', 'Your order has been approved');
      } else {
        throw APIException(
          message: res.data,
          statusCode: res.statusCode ?? 1000,
        );
      }
    } on APIException catch (e) {
      log('Failed to approve order ${e.statusCode} Error: ${e.message}');
    } on DioError catch (e) {
      log(
        'Failed to approve order ${e.response?.data} Error: ${e.response?.statusMessage}',
      );
    }
  }

  Future<User> saveUserBillingDetails({
    required String address,
    required phone,
  }) async {
    User result = User.empty();
    try {
      final User user = ref.read(userProvider);
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-billing-details'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          AppConstants.authToken: user.token,
        },
        body: jsonEncode({
          'address': address,
          'phone': phone,
        }),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        final UserNotifier userNotifier = ref.read(userProvider.notifier);

        final User user = User.fromMap(jsonDecode(res.body));
        userNotifier.updateAddress(address: user.address);
        userNotifier.updatePhone(value: user.phone);
        return user;
      } else {
        throw APIException(message: res.body, statusCode: res.statusCode);
      }
    } on APIException catch (e) {
      log('Failed to save billing details${e.statusCode} Error: ${e.message}');
      dropperMessage('ATTENTION',
          'Failed to save billing details. Please try again later');
    } catch (e) {
      dropperMessage('ATTENTION',
          'Failed to save billing details. Please try again later');

      log('Could not save address. Check Address Services File: $e');
    }
    return result;
  }

  Future<int> getProductQuantity({required String productId}) async {
    int result = -1;

    try {
      final user = ref.read(userProvider);
      final http.Response res = await http
          .get(Uri.parse('$uri/product/quantity/$productId'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        AppConstants.authToken: user.token,
      });

      if (res.statusCode == 200) {
        result = jsonDecode(res.body);
        log('$result');
      } else {
        throw APIException(
          message: res.body,
          statusCode: res.statusCode,
        );
      }
    } on APIException catch (e) {
      log('Failed to get product quantity ${e.statusCode} error: ${e.message}');
    } catch (e) {
      log('Failed to get product quantity $e');
    }

    return result;
  }

  Future<void> syncCart() async {
    final user = ref.read(userProvider);
    try {
      final response = await http.get(
          Uri.parse(
            '$uri/cart/sync/${user.id}',
          ),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            AppConstants.authToken: user.token,
          });

      if (response.statusCode == 200) {
        // final userCart = jsonDecode(response.body);
        ref
            .read(userProvider.notifier)
            .updateCart(cart: jsonDecode(response.body));
      } else {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
    } on APIException catch (e) {
      log('Failed to sync user cart ${e.message}');
    } catch (e) {
      log('Failed to sync user cart $e');
    }
  }
}
