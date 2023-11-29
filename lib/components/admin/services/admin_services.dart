import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';

//Double Used Here!

class AdminServices {
  final FirebaseStorage firebaseStorage;
  final Ref ref;
  AdminServices({required this.ref, required this.firebaseStorage});

  // Future<String> addProduct({
  //   required BuildContext context,
  //   required String name,
  //   required String description,
  //   required String category,
  //   required double quantity,
  //   required double price,
  //   required String createdAt,
  //   required final String date,
  //   String status = 'Available',
  //   required List<File> images,
  //   required List<File> models,
  // }) async {
  //   String result = '';

  //   try {
  //     final User user = ref.read(userProvider);
  //     x.Get.snackbar('Product Is Being Uploded',
  //         'Hang on until you\'re directed to the product screen ');

  //     Future<List<String>> getModelUrl() async {
  //       List<String> modelUrl = [];
  //       final filePath = '$name/model/$name.glb';
  //       for (var i = 0; i < models.length; i++) {
  //         final file = File(models[i].path);
  //         final Reference ref = firebaseStorage.ref().child(filePath);
  //         final UploadTask task = ref.putFile(file);
  //         final TaskSnapshot snapshot = await task.whenComplete(() => null);
  //         final downloadUrl = await snapshot.ref.getDownloadURL();
  //         modelUrl.add(downloadUrl);
  //       }
  //       return modelUrl;
  //     }

  //     Future<List<String>> getImageUrl() async {
  //       List<String> imageUrl = [];
  //       for (var i = 0; i < images.length; i++) {
  //         final Reference ref =
  //             firebaseStorage.ref().child('$name/image/$name');
  //         final UploadTask task = ref.putFile(File(images[i].path));
  //         final TaskSnapshot snapshot =
  //             await task.whenComplete(() => log('Image Uploaded'));
  //         final String downloadUrl = await snapshot.ref.getDownloadURL();
  //         imageUrl.add(downloadUrl);
  //       }
  //       return imageUrl;
  //     }

  //     List<String> modelUrls = await getModelUrl();
  //     List<String> imageUrls = await getImageUrl();

  //     //....................................................................................

  //     Product product = Product(
  //       createdAt: createdAt,
  //       status: status,
  //       name: name,
  //       description: description,
  //       quantity: quantity,
  //       price: price,
  //       category: category,
  //       images: imageUrls,
  //       models: modelUrls,
  //     );

  //     http.Response res = await http.post(
  //       Uri.parse('$uri/admin/add-product'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         AppConstants.authToken: user.token,
  //       },
  //       body: product.toJson(),
  //     );

  //     if (res.statusCode == 200 || res.statusCode == 201) {
  //       showSnackBar('SUCCESS', 'Products added successfully!');
  //       final Product response = Product.fromJson(res.body);
  //       ref.invalidate(fetchAllProductsProvider);

  //       result = jsonEncode(response);

  //       Future.delayed(Duration.zero)
  //           .then((value) => x.Get.off(() => const AdminTab()));
  //     } else {
  //       throw APIException(message: res.body, statusCode: res.statusCode);
  //     }

  //   } on APIException catch (e) {
  //     showSnackBar('ATTENTION', 'An error occured while uploading item');
  //     log('Failed to upload product ${e.statusCode} Error: ${e.message}');
  //   } catch (e) {
  //     showSnackBar('ATTENTION', 'An error occured while uploading item');
  //     log('Failed to add product: $e');
  //   }
  //   return result;
  // }

  // void updateProduct({
  //   required BuildContext context,
  //   required String name,
  //   required String description,
  //   required String category,
  //   required double quantity,
  //   required double price,
  //   required String status,
  //   required Product oldProduct,
  //   required List<File> images,
  //   required List<File> models,
  // }) async {
  //   try {
  //     final User user = ref.read(userProvider);
  //     x.Get.snackbar('Updating Item', 'Please Standby');
  //     //Upload model and get URL from firebase storage

  //     List<String> modelUrls = [];

  //     if (models.isNotEmpty) {
  //       for (var i = 0; i < models.length; i++) {
  //         final Reference ref =
  //             firebaseStorage.ref().child('$name/model/$name.glb');
  //         final UploadTask task = ref.putFile(File(models[i].path));
  //         final TaskSnapshot snapshot = await task.whenComplete(() => null);
  //         final String downloadUrl = await snapshot.ref.getDownloadURL();
  //         modelUrls.add(downloadUrl);
  //       }
  //     } else {
  //       final Reference ref =
  //           firebaseStorage.ref().child('$name/model/$name.glb');
  //       final String downloadUrl = await ref.getDownloadURL();
  //       modelUrls.add(downloadUrl);
  //     }

  //     //Upload image and get URL from firebase storage
  //     // final FirebaseStorage storage2 = FirebaseStorage.instance;
  //     List<String> imageUrls = [];

  //     if (images.isNotEmpty) {
  //       for (var i = 0; i < images.length; i++) {
  //         final Reference ref =
  //             firebaseStorage.ref().child('$name/image/$name');
  //         final UploadTask task = ref.putFile(File(images[i].path));
  //         final TaskSnapshot snapshot =
  //             await task.whenComplete(() => log('Image Uploaded'));
  //         final String downloadUrl = await snapshot.ref.getDownloadURL();
  //         imageUrls.add(downloadUrl);
  //         log('Got image put');
  //       }
  //     } else {
  //       final Reference reff = firebaseStorage.ref().child('$name/image/$name');
  //       final String downloadUrll = await reff.getDownloadURL();
  //       imageUrls.add(downloadUrll);
  //     }

  //     //....................................................................................

  //     Product product = Product(
  //       id: oldProduct.id,
  //       name: name,
  //       description: description,
  //       quantity: quantity,
  //       price: price,
  //       category: category,
  //       status: status,
  //       images: imageUrls,
  //       models: modelUrls,
  //     );
  //     log(imageUrls.length.toString());

  //     http.Response res = await http.put(
  //       Uri.parse('$uri/admin/update-product/${oldProduct.id}'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         AppConstants.authToken: user.token,
  //       },
  //       body: product.toJson(),
  //     );

  //     if (res.statusCode == 200 || res.statusCode == 201) {
  //       showSnackBar('SUCCESS', 'Product has been updated successfully');
  //       if (context.mounted) {
  //         Navigator.pop(context);
  //       }
  //     } else {
  //       throw APIException(message: res.body, statusCode: res.statusCode);
  //     }
  //   } on APIException catch (e) {
  //     showSnackBar('ATTENTION', 'An error occured while uploading item');
  //     log('Failed to upload product ${e.statusCode} Error: ${e.message}');
  //   } catch (e) {
  //     showSnackBar('ATTENTION', 'An error occured while updating item');
  //     log('Failed to update product: $e');
  //   }
  // }

  //get FcmToken
  // uploadFcmToken({required String fcmToken, required String email}) async {
  //   try {
  //     final dio = Dio();
  //     Response res = await dio.post('$uri/admin/add/fcmtoken',
  //         options: Options(
  //           contentType: Headers.jsonContentType,
  //         ),
  //         data: {
  //           'fcmToken': fcmToken,
  //           'email': email,
  //         });

  //     if (res.statusCode == 200 || res.statusCode == 201) {
  //       log('FCM token updated');
  //     } else {
  //       throw APIException(
  //           message: res.data, statusCode: res.statusCode ?? 100);
  //     }
  //   } on APIException catch (e) {
  //     log(
  //       'User FCM token was not updated: ${e.statusCode} error: ${e.message}',
  //     );
  //   } catch (e) {
  //     log('Failed to update FCM token: $e');
  //   }
  // }

  // Future<int> changeOrderStatus({
  //   required BuildContext context,
  //   required int status,
  //   required Order order,
  // }) async {
  //   int changedStatus = 0;
  //   try {
  //     final User user = ref.read(userProvider);

  //     http.Response res = await http.post(
  //       Uri.parse('$uri/admin/change-order-status'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         AppConstants.authToken: user.token,
  //       },
  //       body: jsonEncode(
  //         {
  //           'id': order.id,
  //           'status': status,
  //         },
  //       ),
  //     );

  //     if (res.statusCode == 200 || res.statusCode == 201) {
  //       final Order response = Order.fromMap(jsonDecode(res.body));
  //       log('Status Changed: ${response.status}');
  //       changedStatus = ref.read(orderProvider.notifier).copyStatusWith(
  //             status: response.status,
  //           );
  //     } else {
  //       throw APIException(message: res.body, statusCode: res.statusCode);
  //     }
  //   } on APIException catch (e) {
  //     log('APIException: Failed to change order status: ${e.statusCode} Error: ${e.message}');
  //   } catch (e) {
  //     log('Failed to update order status $e');
  //   }

  //   return changedStatus;
  // }

  // Get all the Products
  // Future<List<Product>> fetchAllProduct() async {
  //   List<Product> productList = [];
  //   try {
  //     final User user = ref.read(userProvider);
  //     http.Response res =
  //         await http.get(Uri.parse('$uri/admin/get-products'), headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       AppConstants.authToken: user.token,
  //     });

  //     if (res.statusCode == 200 || res.statusCode == 201) {
  //       List<Product> products = List.from(jsonDecode(res.body) as List)
  //           .map((product) => Product.fromMap(product))
  //           .toList();

  //       productList = products;
  //     } else {
  //       throw APIException(message: res.body, statusCode: res.statusCode);
  //     }
  //   } on APIException catch (e) {
  //     showSnackBar('ATTENTION', 'An error occurred while fetching products');
  //     log('Failed to fetch products: ${e.statusCode} Error: ${e.message}');
  //   } catch (e) {
  //     showSnackBar('ATTENTION', 'An error occurred while fetching products');
  //     log('Error: Failed to fetch products: $e');
  //   }
  //   return productList;
  // }

  // Future<List<User>> fetchAllUsers(BuildContext context) async {
  //   final List<User> users = [];
  //   final dio = Dio();
  //   try {
  //     Response res = await dio.get(
  //       "$uri/admin/fetch-users",
  //       options: Options(
  //         contentType: Headers.jsonContentType,
  //       ),
  //     );
  //     log('Got here');

  //     dioErrorHandling(
  //         response: res,
  //         onSuccess: () {
  //           log('Got here');
  //           // for (int p = 0; p < jsonDecode(res.data).length; p++) {
  //           //   users.add(
  //           //     User.fromJson(
  //           //       jsonEncode(
  //           //         jsonDecode(res.data)[p],
  //           //       ),
  //           //     ),
  //           //   );
  //           // }
  //           // log('User: $users');
  //         });
  //   } catch (e) {
  //     log('Fetch User Error: $e');
  //   }
  //   return users;
  // }

  // Future<List<User>> fetchAllUsers() async {
  //   List<User> userList = [];
  //   try {
  //     final User user = ref.read(userProvider);
  //     http.Response res =
  //         await http.get(Uri.parse('$uri/admin/get-users'), headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       AppConstants.authToken: user.token,
  //     });
  //     log('Fetch all product Res: ${res.body}');
  //     httpErrorHandling(
  //         response: res,
  //         onSuccess: () {
  //           for (int p = 0; p < jsonDecode(res.body).length; p++) {
  //             userList.add(
  //               User.fromJson(
  //                 jsonEncode(
  //                   jsonDecode(res.body)[p],
  //                 ),
  //               ),
  //             );
  //           }
  //         });
  //   } catch (e) {
  //     showSnackBar('Something went wrong',
  //         'Check your internet connection and restart the app');
  //     log('Error: Could not get product');
  //   }
  //   return userList;
  // }

  // Future<String> deleteProduct({
  //   required Product product,
  // }) async {
  //   String productRes = '';
  //   try {
  //     final User user = ref.read(userProvider);
  //     http.Response res = await http.post(
  //       Uri.parse('$uri/admin/delete-product'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         AppConstants.authToken: user.token,
  //       },
  //       body: jsonEncode(
  //         {'id': product.id},
  //       ),
  //     );
  //     if (res.statusCode == 200 || res.statusCode == 201) {
  //       final Product response = Product.fromJson(res.body);
  //       productRes = jsonEncode(response);

  //       ref.invalidate(fetchAllProductsProvider);
  //     } else {
  //       throw APIException(message: res.body, statusCode: res.statusCode);
  //     }
  //   } catch (e) {
  //     showSnackBar('ATTENTION', 'An error occurred. Please try again later');
  //     log('Error: Could not delete product!: $e');
  //   }
  //   return productRes;
  // }
  //..................................................................................................

  //..................................................................................................................

  // Future<List<Order>> fetchOrders() async {
  //   final User user = ref.read(userProvider);
  //   List<Order> orderList = [];
  //   try {
  //     http.Response res =
  //         await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
  //       // Access-Control-Allow-Origin: 'https://amazing.site'
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       AppConstants.authToken: user.token,
  //     });

  //     if (res.statusCode == 200 || res.statusCode == 201) {
  //       final List orderDecode = jsonDecode(res.body);
  //       final List<Order> order = orderDecode.map((order) {
  //         return ref
  //             .read(orderProvider.notifier)
  //             .updateOrder(order: jsonEncode(order));
  //       }).toList();
  //       orderList = order;
  //     } else {
  //       throw APIException(message: res.body, statusCode: res.statusCode);
  //     }
  //   } on APIException catch (e) {
  //     log('Failed to fetch failed orders ${e.statusCode}: Error: ${e.message}');
  //   } catch (e) {
  //     log('Failed to fetch all orders$e');
  //   }
  //   return orderList;
  // }

  // Future<List<Order>> fetchFailedOrders() async {
  //   final User user = ref.read(userProvider);
  //   List<Order> orderList = [];
  //   try {
  //     http.Response res =
  //         await http.get(Uri.parse('$uri/admin/get-failed-orders'), headers: {
  //       // Access-Control-Allow-Origin: 'https://amazing.site'
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       AppConstants.authToken: user.token,
  //     });

  //     if (res.statusCode == 200 || res.statusCode == 201) {
  //       final List orderDecode = jsonDecode(res.body);

  //       final List<Order> orders = orderDecode.map((order) {
  //         final Order updatedOrder = ref
  //             .read(orderProvider.notifier)
  //             .updateOrder(order: jsonEncode(order));
  //         return updatedOrder;
  //       }).toList();

  //       orderList = orders;
  //     } else {
  //       throw APIException(message: res.body, statusCode: res.statusCode);
  //     }
  //   } on APIException catch (e) {
  //     log('Failed to fetch failed orders ${e.statusCode}: Error: ${e.message}');
  //   } catch (e) {
  //     log('Failed to fetch all orders$e');
  //   }
  //   return orderList;
  // }

  // Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
  //   final User user = ref.read(userProvider);
  //   List<Sales> sales = [];
  //   dynamic totalEarning = 0;
  //   try {
  //     http.Response res =
  //         await http.get(Uri.parse('$uri/admin/analytics'), headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       AppConstants.authToken: user.token,
  //     });

  //     httpErrorHandling(
  //         response: res,
  //         onSuccess: () {
  //           var response = jsonDecode(res.body);
  //           totalEarning = response['totalEarnings'];
  //           // log('Got here!');

  //           sales = [
  //             Sales('Sofas', response['sofasEarnings']),
  //             Sales('Armchairs', response['armchairsEarnings']),
  //             Sales('Tables', response['tablesEarnings']),
  //             Sales('Beds', response['bedsEarnings']),
  //             Sales('Accessories', response['accessoriesEarnings']),
  //             Sales('Lights', response['lightsEarnings']),
  //           ];
  //         });
  //   } catch (e) {
  //     showSnackBar('Something Is Not Right', 'Failed To Update Analysis');
  //     log('Analytic Error: $e');
  //   }
  //   return {
  //     'sales': sales,
  //     'totalEarning': totalEarning,
  //   };
  // }

  // Future<int> fetchOrderStatus({required Order order}) async {
  //   final User user = ref.read(userProvider);
  //   int orderStatus = 0;
  //   try {
  //     http.Response res = await http.get(
  //       Uri.parse('$uri/admin/get-order-status/${order.id}'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         AppConstants.authToken: user.token,
  //       },
  //     );
  //     log(res.body);

  //     httpErrorHandling(
  //         response: res,
  //         onSuccess: () {
  //           orderStatus = ref.read(orderProvider.notifier).copyStatusWith(
  //                 status: jsonDecode(res.body),
  //               );
  //           // if (res.statusCode == 200) {
  //           //   ref.read(currentStepProvider.notifier).update(
  //           //         (state) => state = jsonDecode(res.body),
  //           //       );
  //           // }
  //         });
  //   } catch (e) {
  //     // showSnackBar(errorMessageTitle, errorMesssage);
  //     log('Error: Could not get product $e');
  //   }
  //   return orderStatus;
  // }
}
