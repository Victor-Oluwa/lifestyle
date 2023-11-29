// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:lifestyle/models-classes/order.dart';

import '../../../../Common/widgets/app_constants.dart';
import '../../../../core/error/exception/api_exception.dart';
import '../../../../models-classes/user.dart';
import '../../../../state/providers/provider_model/orders_provider.dart';
import '../../../../state/providers/provider_model/user_provider.dart';

class OrderServices {
  OrderServices(
    this.ref,
  );
  final Ref ref;

  Future<int> changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
  }) async {
    int changedStatus = 0;
    try {
      final User user = ref.read(userProvider);

      http.Response res = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          AppConstants.authToken: user.token,
        },
        body: jsonEncode(
          {
            'id': order.id,
            'status': status,
          },
        ),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        final Order response = Order.fromMap(jsonDecode(res.body));
        log('Status Changed: ${response.status}');
        changedStatus = ref.read(orderProvider.notifier).copyStatusWith(
              status: response.status,
            );
      } else {
        throw APIException(message: res.body, statusCode: res.statusCode);
      }
    } on APIException catch (e) {
      log('APIException: Failed to change order status: ${e.statusCode} Error: ${e.message}');
    } catch (e) {
      log('Failed to update order status $e');
    }

    return changedStatus;
  }

  Future<List<Order>> fetchOrders() async {
    final User user = ref.read(userProvider);
    List<Order> orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
        // Access-Control-Allow-Origin: 'https://amazing.site'
        'Content-Type': 'application/json; charset=UTF-8',
        AppConstants.authToken: user.token,
      });

      if (res.statusCode == 200 || res.statusCode == 201) {
        final List orderDecode = jsonDecode(res.body);
        final List<Order> order = orderDecode.map((order) {
          return ref
              .read(orderProvider.notifier)
              .updateOrder(order: jsonEncode(order));
        }).toList();
        orderList = order;
      } else {
        throw APIException(message: res.body, statusCode: res.statusCode);
      }
    } on APIException catch (e) {
      log('Failed to fetch failed orders ${e.statusCode}: Error: ${e.message}');
    } catch (e) {
      log('Failed to fetch all orders$e');
    }
    return orderList;
  }

  Future<List<Order>> fetchFailedOrders() async {
    final User user = ref.read(userProvider);
    List<Order> orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-failed-orders'), headers: {
        // Access-Control-Allow-Origin: 'https://amazing.site'
        'Content-Type': 'application/json; charset=UTF-8',
        AppConstants.authToken: user.token,
      });

      if (res.statusCode == 200 || res.statusCode == 201) {
        final List orderDecode = jsonDecode(res.body);

        final List<Order> orders = orderDecode.map((order) {
          final Order updatedOrder = ref
              .read(orderProvider.notifier)
              .updateOrder(order: jsonEncode(order));
          return updatedOrder;
        }).toList();

        orderList = orders;
      } else {
        throw APIException(message: res.body, statusCode: res.statusCode);
      }
    } on APIException catch (e) {
      log('Failed to fetch failed orders ${e.statusCode}: Error: ${e.message}');
    } catch (e) {
      log('Failed to fetch all orders$e');
    }
    return orderList;
  }
}
