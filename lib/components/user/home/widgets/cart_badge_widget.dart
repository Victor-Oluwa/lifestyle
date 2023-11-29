import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/common/widgets/medium_text.dart';
import 'package:lifestyle/models-classes/user.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:badges/badges.dart' as cart;


class CartBadgeWidget extends StatelessWidget {
  const CartBadgeWidget({
    super.key,
    required this.user,
    required this.ref,
  });

  final User user;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return cart.Badge(
      badgeContent: MediumText(
        text: '${user.cart.length}',
        color: Colors.black,
        font: 'Cera',
      ),
      badgeStyle: const cart.BadgeStyle(
        badgeColor: Colors.transparent,
        elevation: 0,
      ),
      child: Container(
          padding: EdgeInsets.all(5.sp),
          child: const Icon(Icons.shopping_cart_checkout)),
    );
  }
}
