// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:lifestyle/components/app_constants.dart';
// import 'package:lifestyle/components/error_handling.dart';
// import 'package:lifestyle/components/utils.dart';
// import 'package:lifestyle/providers/user_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import '../../models/product.dart';
// import '../../models/user.dart';

// class ProductDetailsServices {
//   void addTocart({
//     required BuildContext context,
//     required Product product,
//   }) async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);

//     try {
//       http.Response res = await http.post(Uri.parse('$uri/api/add-to-cart'),
//           headers: {
//             'Content-Type': 'application/json; charset=UTF-8',
//             AppConstants.authToken: userProvider.user.token
//           },
//           body: jsonEncode(
//             {
//               'id': product.id,
//             },
//           ));
//       httpErrorHandling(
//           response: res,
//           context: context,
//           onSuccess: () {
//             User user =
//                 userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
//             userProvider.setUserFromModel(user);
//           });
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }
// }

// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart' as x;
// import 'package:lifestyle/Common/app_constants.dart';
// import 'package:lifestyle/providers/user_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:dio/dio.dart'; // Replace 'http' with 'dio'
// import '../../../Common/error_handling.dart';
// import '../../../Common/utils.dart';
// import '../../../models/product.dart';
// import '../../../models/user.dart';

// class ProductDetailsServices {
  // final Dio _dio = Dio();
  // void addTocart({
  //   required BuildContext context,
  //   required Product product,
  // }) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);

  //   try {
  //     Response res = await _dio.post(
  //       '$uri/api/add-to-cart', // Update to use Dio
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           AppConstants.authToken: userProvider.user.token,
  //         },
  //       ),
  //       data: jsonEncode(
  //         {
  //           'id': product.id,
  //         },
  //       ),
  //     );

  //     dioErrorHandling(
  //       response: res,
  //       onSuccess: () {
  //         // User user =
  //         //     userProvider.user.copyWith(cart: jsonDecode(res.data)['cart']);
  //         // userProvider.setUserFromModel(user);
  //         log(res.data.toString());
  //         User user = userProvider.user.copyWith(cart: res.data['cart']);
  //         userProvider.setUserFromModel(user);

  //         x.Get.snackbar('Success', 'Item has been added to your cart');
  //       },
  //     );

  //     //Had to make this changes after replacing http with dio

  //     // User user =
  //     //     userProvider.user.copyWith(cart: jsonDecode(res.data)['cart']);
  //     // userProvider.setUserFromModel(user);
  //   } on DioError catch (e) {
  //     // Update error handling to use DioError
  //     if (e.response != null) {
  //       showSnackBar(errorMessageTitle, errorMesssage);
  //       // showSnackBar(context, 'Dio error! STATUS: ${e.response?.statusCode}');
  //       log('Dio error! STATUS: ${e.response?.statusCode}');
  //     } else {
  //       x.Get.snackbar('Failed', 'Something went wrong');

  //       log('Error sending request! MESSAGE: ${e.message}');
  //     }
  //   }
  // }
// }






// httpErrorHandling(
      //     response: res,
      //     context: context,
      //     onSuccess: () {
      //       User user =
      //           userProvider.user.copyWith(cart: jsonDecode(res.data)['cart']);
      //       userProvider.setUserFromModel(user);
      //     });