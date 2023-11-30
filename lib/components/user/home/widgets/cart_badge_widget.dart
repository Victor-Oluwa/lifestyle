// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:badges/badges.dart' as cart;
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/common/widgets/medium_text.dart';
import 'package:lifestyle/models-classes/user.dart';

class CartBadgeWidget extends StatelessWidget {
  const CartBadgeWidget({
    Key? key,
    required this.user,
    required this.ref,
    required this.iconData,
  }) : super(key: key);

  final User user;
  final WidgetRef ref;
  final IconData iconData;

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
          child: Icon(
            iconData,
            color: LifestyleColors.kTaupeDarkened,
          )),
    );
  }
}
