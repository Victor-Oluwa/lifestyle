import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/components/user/cart/functions/cart_functions.dart';
import 'package:lifestyle/components/user/cart/widgets/cart_item_widget.dart';
import 'package:lifestyle/models-classes/cart.dart';

class CartListView extends StatelessWidget {
  const CartListView({
    super.key,
    required this.cart,
    required this.cartFunction,
    required this.ref,
  });
  final WidgetRef ref;
  final List<Cart> cart;
  final CartFunctions cartFunction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            final Cart userCart = cart[index];
            return CartItemWidget(
              context: context,
              cart: userCart,
            );
          }),
    );
  }
}
