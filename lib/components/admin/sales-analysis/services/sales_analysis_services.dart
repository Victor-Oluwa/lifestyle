// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../../Common/widgets/app_constants.dart';
import '../../../../Common/widgets/utils.dart';
import '../../../../common/widgets/error_handling.dart';
import '../../../../models-classes/sales.dart';
import '../../../../models-classes/user.dart';
import '../../../../state/providers/provider_model/user_provider.dart';

class SalesAnalysisServices {
  SalesAnalysisServices({
    required this.ref,
  });
  final Ref ref;

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final User user = ref.read(userProvider);
    List<Sales> sales = [];
    dynamic totalEarning = 0;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/analytics'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        AppConstants.authToken: user.token,
      });

      httpErrorHandling(
          response: res,
          onSuccess: () {
            var response = jsonDecode(res.body);
            totalEarning = response['totalEarnings'];
            // log('Got here!');

            sales = [
              Sales('Sofas', response['sofasEarnings']),
              Sales('Armchairs', response['armchairsEarnings']),
              Sales('Tables', response['tablesEarnings']),
              Sales('Beds', response['bedsEarnings']),
              Sales('Accessories', response['accessoriesEarnings']),
              Sales('Lights', response['lightsEarnings']),
            ];
          });
    } catch (e) {
      dropperMessage('Something Is Not Right', 'Failed To Update Analysis');
      log('Analytic Error: $e');
    }
    return {
      'sales': sales,
      'totalEarning': totalEarning,
    };
  }
}
