import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:lifestyle/models-classes/user.dart';

import '../../../../Common/widgets/app_constants.dart';
import '../../../../core/error/exception/api_exception.dart';
import '../../../../Common/widgets/error_handling.dart';
import '../../../../models-classes/order.dart';
import '../../../../state/providers/provider_model/orders_provider.dart';
import '../../../../state/providers/provider_model/user_provider.dart';

class OrderDetailsServices {
  OrderDetailsServices({required this.ref});
  final Ref ref;

  Future<int> fetchOrderStatus({required Order order}) async {
    final User user = ref.read(userProvider);
    int orderStatus = 0;
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-order-status/${order.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          AppConstants.authToken: user.token,
        },
      );
      log(res.body);

      httpErrorHandling(
          response: res,
          onSuccess: () {
            orderStatus = ref.read(orderProvider.notifier).copyStatusWith(
                  status: jsonDecode(res.body),
                );
            // if (res.statusCode == 200) {
            //   ref.read(currentStepProvider.notifier).update(
            //         (state) => state = jsonDecode(res.body),
            //       );
            // }
          });
    } catch (e) {
      // showSnackBar(errorMessageTitle, errorMesssage);
      log('Error: Could not get product $e');
    }
    return orderStatus;
  }

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

  Future<http.Response> createReceipt(Map<String, dynamic> receiptDetails) {
    final url = 'https://invoice.zoho.com/api/v1/receipts';
    final headers = {
      'Authorization': 'Zoho-oauthtoken YOUR_OAUTH_TOKEN',
      'Content-Type': 'application/json'
    };
    final body = jsonEncode(receiptDetails);

    return http.post(Uri.parse(url), headers: headers, body: body);
  }
}
