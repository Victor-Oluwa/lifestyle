import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart' as x;
import 'package:lifestyle/routes-management/lifestyle_routes_names.dart';

class OrderFunctions {
  final Ref ref;
  OrderFunctions({required this.ref});

  // List<Order>? orderss;
  // void fetchOrders() async {
  //   await ref.read(adminServicesProvider).fetchAllOrders();
  // }

  navigateToOrderDetailScren(order) {
    x.Get.toNamed(LifestyleRouteName.orderDetailsRoute, arguments: order);
  }
}
