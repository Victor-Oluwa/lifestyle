import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lifestyle/core/error/exception/api_exception.dart';

import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/common/widgets/utils.dart';
import 'package:lifestyle/models-classes/order.dart';

import '../../../../../models-classes/user.dart';
import '../../../../state/providers/provider_model/user_provider.dart';
import '../../../storage/secure_storage_provider.dart';
import '../../auth/screen/login.dart';

class ProfileServices {
  final Ref ref;
  ProfileServices({
    required this.ref,
  });
  Future<List<Order>> fetchMyOrders() async {
    final User userNotifier = ref.read(userProvider);

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/orders/me'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userNotifier.token,
      });

      if (res.statusCode == 200 || res.statusCode == 201) {
        List<Order> orders = (jsonDecode(res.body) as List)
            .map((order) => Order.fromMap(order))
            .toList();
        orders = orders.where((order) => order.paid == true).toList();
        return orders;
      } else {
        throw APIException(message: res.body, statusCode: res.statusCode);
      }
    } on APIException catch (e) {
      log('Failed to fetch orders: ${e.message} Error: ${e.statusCode}');
      return [];
    } catch (e) {
      throw APIException(message: '$e', statusCode: 500);
    }
  }

  void logOut() async {
    try {
      final secureStorage = ref.read(secureStorageProvider);

      await secureStorage.deleteSecureData(AppConstants.authToken);
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      dropperMessage('ATTENTION', 'An error occurred. Please try again later');
      log('Failed to logOut: $e');
    }
  }
}
