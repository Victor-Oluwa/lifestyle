import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/components/admin/all-products/functions/all_products_function.dart';
import 'package:lifestyle/components/admin/widgets/post_screen_fab.dart';
import 'package:lifestyle/components/user/home/screens/tab_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Common/widgets/medium_text.dart';
import '../../../../state/providers/actions/provider_operations.dart';

class AllProductsScreen extends ConsumerWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProductsFunction = ref.read(allProductsFunctionProvider);
    return Scaffold(
      backgroundColor: lightTaupe,
      appBar: buildAppbar(allProductsFunction),
      body: allProductsFunction.buildAllProductView(
          ref: ref, allProductsFunction: allProductsFunction),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          ActionButton(postScreenFunctoin: allProductsFunction),
    );
  }

  AppBar buildAppbar(AllProductFunctions allProductsFunction) {
    return AppBar(
      actions: [
        buildSwitchToUserButton(),
        buildLogoutButton(allProductsFunction),
      ],
      elevation: 0,
      backgroundColor: Colors.black,
      title: MediumText(
        font: comorant,
        text: 'All Products'.toUpperCase(),
        color: Colors.white,
        size: 16.sp,
      ),
    );
  }

  IconButton buildSwitchToUserButton() {
    return IconButton(
        onPressed: () async {
          await Get.offAll(() => const TabPage());
        },
        icon: const Icon(Icons.switch_account));
  }

  Padding buildLogoutButton(AllProductFunctions allProductsFunction) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
          allProductsFunction.logOut();
        },
        child: Icon(
          Icons.close,
          size: 21.sp,
        ),
      ),
    );
  }
}
