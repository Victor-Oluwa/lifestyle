import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/models-classes/order.dart';


final orderProvider = StateNotifierProvider<OrderNotifier, Order>(
  (ref) => OrderNotifier(),
);

class OrderNotifier extends StateNotifier<Order> {
  OrderNotifier()
      : super(
          Order(
              customerName: '',
              paid: false,
              id: '',
              products: [],
              quantity: [],
              address: '',
              userId: '',
              orderTime: 0,
              status: 0,
              totalPrice: 0.0),
        );

  Order updateOrder({required String order}) {
    state = Order.fromJson(order);
    return state;
  }

  int copyStatusWith({required int status}) {
    state = state.copyWith(status: status);
    return state.status;
  }
}
