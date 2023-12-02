import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:lifestyle/Common/widgets/utils.dart';
import 'package:lifestyle/core/error/exception/api_exception.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:lifestyle/state/providers/provider_model/user_provider.dart';

import '../../../../../Common/widgets/snackbar_messages.dart';

class PaystackServices {
  PaystackServices({required this.ref});

  final Ref ref;

  Future<Map<String, dynamic>> initializePayment({
    required int amount,
    required String email,
  }) async {
    final Map<String, dynamic> result = {};
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/transaction-initialize'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $testKey',
        },
        body: jsonEncode({
          'amount': amount,
          'email': email,
        }),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        dev.log('Returned statusCode: ${res.statusCode}');
        return json.decode(res.body) as Map<String, dynamic>;
      } else {
        ref.invalidate(isProcessingProvider);
        throw APIException(
          message: jsonEncode(res.body),
          statusCode: res.statusCode,
        );
      }
    } on APIException catch (e) {
      dropperMessage(
        kPaymentInitialisationErrorMessage['Title'],
        kPaymentInitialisationErrorMessage['Body'],
      );
      dev.log('${e.statusCode} initializePayment Error: ${e.message}');
      return result;
    } catch (e) {
      dev.log('Payment Initialisation Error $e');
    }
    return result;
  }

  Future<bool> verifyPaymentOnBackend(
      {required String transactionReference}) async {
    final user = ref.read(userProvider);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/verify-payment'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          //  'Authorization': 'Bearer $testKey',
        },
        body: jsonEncode({
          'transactionReference': transactionReference,
          'userId': user.id,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ref.invalidate(isProcessingProvider);
        return true;
      } else {
        ref.invalidate(isProcessingProvider);
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on APIException catch (e) {
      dev.log('${e.statusCode} Error: ${e.message}');
      return false;
    } catch (e) {
      ref.invalidate(isProcessingProvider);
      dev.log('Failed to Verify payment: $e');
      return false;
    }
  }
}
