// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../../Common/widgets/app_constants.dart';
import '../../../../core/error/exception/api_exception.dart';
import '../../../../Common/widgets/utils.dart';
import '../../../../models-classes/product.dart';
import '../../../../models-classes/user.dart';
import '../../../../state/providers/actions/provider_operations.dart';
import '../../../../state/providers/provider_model/user_provider.dart';

class AllProductsServices {
  AllProductsServices({
    required this.ref,
  });
  final Ref ref;

  Future<List<Product>> fetchAllProduct() async {
    List<Product> productList = [];
    try {
      final User user = ref.read(userProvider);
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-products'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        AppConstants.authToken: user.token,
      });

      if (res.statusCode == 200 || res.statusCode == 201) {
        List<Product> products = List.from(jsonDecode(res.body) as List)
            .map((product) => Product.fromMap(product))
            .toList();
        productList = products;
      } else {
        throw APIException(message: res.body, statusCode: res.statusCode);
      }
    } on APIException catch (e) {
      dropperMessage('ATTENTION', 'An error occurred while fetching products');
      log('Failed to fetch products: ${e.statusCode} Error: ${e.message}');
    } catch (e) {
      dropperMessage('ATTENTION', 'An error occurred while fetching products');
      log('Error: Failed to fetch products: $e');
    }
    return productList;
  }

  Future<String> deleteProduct({
    required Product product,
  }) async {
    String productRes = '';
    try {
      final User user = ref.read(userProvider);
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          AppConstants.authToken: user.token,
        },
        body: jsonEncode(
          {'id': product.id},
        ),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        final Product response = Product.fromJson(res.body);
        productRes = jsonEncode(response);

        ref.invalidate(fetchAllProductsProvider);
      } else {
        throw APIException(message: res.body, statusCode: res.statusCode);
      }
    } catch (e) {
      dropperMessage('ATTENTION', 'An error occurred. Please try again later');
      log('Error: Could not delete product!: $e');
    }
    return productRes;
  }
}
