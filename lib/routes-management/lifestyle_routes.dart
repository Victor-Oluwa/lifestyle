import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:lifestyle/components/user/cart/screens/cart_details_confirmation_view.dart';
import 'package:lifestyle/components/user/ar/widgets/ar_hidden_menu.dart';
import 'package:lifestyle/components/user/products/product-category/screen/product_view_screen.dart';
import 'package:lifestyle/components/user/Documents/screens/browser_page.dart';
import 'package:lifestyle/components/user/3D/model_view.dart';
import 'package:lifestyle/components/user/cart/screens/cart_main_screen.dart';
import 'package:lifestyle/Common/widgets/empty_screen.dart';
import 'package:lifestyle/components/user/home/screens/tab_page.dart';
import 'package:lifestyle/components/user/products/product-details/screen/product_details_screen.dart';
import 'package:lifestyle/components/admin/add_product/screen/add_product_screen.dart';
import 'package:lifestyle/components/admin/all-products/screen/all_products_screen.dart';
import 'package:lifestyle/components/admin/update-products/screen/update_product.dart';

import 'package:lifestyle/components/admin/order-details/screen/order_details_screen.dart';
import '../components/user/ar/screen/ar_view.dart';
import '../components/user/auth/screen/login.dart';
import '../components/user/auth/screen/register.dart';
import '../components/user/search/screen/search_screen.dart';
import 'lifestyle_routes_names.dart';

List<GetPage> getPages = [
  GetPage(
    name: LifestyleRouteName.homePageRoute,
    page: () => const TabPage(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: LifestyleRouteName.updateProductRoute,
    page: () => const UpdateProduct(),
    transition: Transition.fadeIn,
  ),
  GetPage(
      name: LifestyleRouteName.signUpRoute,
      page: () => const AuthScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: LifestyleRouteName.signInRoute,
      page: () => const AuthSignInScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: LifestyleRouteName.searchScreenRoute,
      page: () => const SearchScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: LifestyleRouteName.categotyRoute,
      page: () => const ProductsViewScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: LifestyleRouteName.orderDetailsRoute,
      page: () => const OrderDetailsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: LifestyleRouteName.productDetailRoute,
      page: () => const ProductDetailsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
    name: LifestyleRouteName.arRoute,
    page: () => const ArView(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: LifestyleRouteName.addProductRoute,
    page: () => const AddProductScreen(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
      name: LifestyleRouteName.postProductRoute,
      page: () => const AllProductsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: LifestyleRouteName.cartRoute,
      page: () => const CartViewScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: LifestyleRouteName.browserRoute,
      page: () => const Browser(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: LifestyleRouteName.modelRoute,
      page: () => const ArModel(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: LifestyleRouteName.empty,
      page: () => const EmptyScreen(color: Colors.transparent),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: LifestyleRouteName.hidden,
      page: () => const ArHiddenMenu(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: LifestyleRouteName.deliveryDetails,
      page: () => const CartDetailsConfirmation(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
];
