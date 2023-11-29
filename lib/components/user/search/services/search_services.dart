import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../../Common/widgets/app_constants.dart';
// import 'package:lifestyle/common/widgets/error_message_widget.dart';
import '../../../../../common/widgets/error_handling.dart';
import '../../../../../common/widgets/utils.dart';
import '../../../../../models-classes/product.dart';
import '../../../../../models-classes/user.dart';
import '../../../../state/providers/provider_model/user_provider.dart';

class SearchServices {
  final Ref ref;
  SearchServices({required this.ref});

  Future<List<Product>> fetchSearchedProduct({
    required String searchQuery,
  }) async {
    final User userNotifier = ref.read(userProvider);
    List<Product> productList = [];
    try {
      if (searchQuery != '') {
        http.Response res = await http
            .get(Uri.parse('$uri/api/products/search/$searchQuery'), headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userNotifier.token,
        });

        httpErrorHandling(
            response: res,
            onSuccess: () {
              for (var i = 0; i < jsonDecode(res.body).length; i++) {
                productList.add(
                  Product.fromJson(
                    jsonEncode(
                      jsonDecode(res.body)[i],
                    ),
                  ),
                );
              }
            });
      } else {
        dropperMessage('Error', 'The text field can\'t be empty');
      }
    } catch (e) {
      log('Error: Could not search for products: $e');
    }
    return productList;
  }
}
