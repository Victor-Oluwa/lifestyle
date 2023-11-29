// import 'package:flutter/material.dart';
// import 'package:lifestyle/features/Home/Screens/category_deals_screen.dart';
// import 'package:lifestyle/features/Home/tab_page.dart';
// import 'package:lifestyle/features/admin/screen/add_product_screen.dart';
// import 'package:lifestyle/features/admin/screen/admin_screen.dart';
// import 'package:lifestyle/features/ar_model/screens/ar-view.dart';
// import 'package:lifestyle/features/auth/screen/auth_screen.dart';
// import 'package:lifestyle/features/auth/screen/sign_in_screen.dart';
// import 'package:lifestyle/models/product.dart';
// // import 'package:model_viewer_plus/model_viewer_plus.dart';
// import 'features/Home/test_screen.dart.dart';

// Route<dynamic> generateRoute(RouteSettings routeSettings) {
//   switch (routeSettings.name) {
//     case AuthScreen.routeName:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (builder) => const AuthScreen(),
//       );

//     // case UpdateProduct.routeName:
//     //   var product = routeSettings.arguments as Product;
//     //   return MaterialPageRoute(
//     //     settings: routeSettings,
//     //     builder: (builder) => UpdateProduct(
//     //       product: product,
//     //     ),
//     //   );

//     case AdminScreen.routeName:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (builder) => const AdminScreen(),
//       );
//     case TestScreen.routeName:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (builder) => const TestScreen(),
//       );
//     // case AddressScreen.routeName:
//     //   var totalAmount = routeSettings.arguments as String;
//     //   return MaterialPageRoute(
//     //     settings: routeSettings,
//     //     builder: (builder) => AddressScreen(amount: totalAmount),
//     //   );
//     /////////////////////////////////////////////////////////////////////////
//     case AuthSignInScreen.routeName:
//       //   var totalAmount = routeSettings.arguments as String;
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (builder) => const AuthSignInScreen(),
//       );
//     // case OrderDetailsScreen.routeName:
//     //   var order = routeSettings.arguments as Order;
//     //   return MaterialPageRoute(
//     //     settings: routeSettings,
//     //     builder: (builder) => OrderDetailsScreen(order: order),
//     //   );
//     // case PendingOrders.routeName:
//     //   var order = routeSettings.arguments as List<Order>;
//     //   return MaterialPageRoute(
//     //     settings: routeSettings,
//     //     builder: (builder) => PendingOrders(order: order),
//     //   );
//     // case SearchScreen.routeName:
//     //   var searchQuery = routeSettings.arguments as String;
//     //   return MaterialPageRoute(
//     //     settings: routeSettings,
//     //     builder: (builder) => SearchScreen(
//     //       searchQuery: searchQuery,
//     //     ),
//     //   );
//     case TabPage.routeName:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (builder) => const TabPage(),
//       );

//     case CategoryDealScreen.routeName:
//       var category = routeSettings.arguments as String;
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (builder) => CategoryDealScreen(),
//       );
//     // case ProductDetailsScreen.routeName:
//     //   var product = routeSettings.arguments as Product;
//     //   return MaterialPageRoute(
//     //       settings: routeSettings,
//     //       builder: (builder) => ProductDetailsScreen(product: product));
//     case Armodel.routeName:
//       var product = routeSettings.arguments as Product;
//       return MaterialPageRoute(
//           settings: routeSettings,
//           builder: (builder) => Armodel(product: product));
//     case AddProductScreen.routeName:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (builder) => const AddProductScreen(),
//       );
//     default:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (builder) => const Scaffold(
//           body: Center(
//             child: Text('This screen does not exist'),
//           ),
//         ),
//       );
//   }
// }
