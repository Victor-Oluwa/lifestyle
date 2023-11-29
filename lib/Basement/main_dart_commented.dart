// import 'dart:async';

// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
// import 'package:lifestyle/Common/general/medium_text.dart';
// import 'package:lifestyle/components/storage/secure_storage_provider.dart';
// import 'package:lifestyle/components/user/notification/function/notification_function.dart';
// import 'package:lifestyle/routes-management/empty_screen.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// import 'package:lifestyle/routes-management/getx_routes_config.dart';
// import 'Common/general/app_constants.dart';
// import 'components/user/auth/screen/init_screen.dart';
// import 'state/providers/actions/provider_operations.dart';
// import 'state/providers/provider_model/user_provider.dart';
// import 'components/user/auth/screen/login.dart';
// import 'models-classes/user.dart';
// import 'components/user/home/screens/tab_page.dart';
// import 'components/admin/admin-tab/admin_tab.dart';
// import 'firebase_options.dart';

// final internetStateProvider = StateProvider((ref) {
//   return false;
// });

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   // await FirebaseNotificationApi().initNotification();
//   runApp(
//     const ProviderScope(child: MyApp()),
//   );
// }

// class MyApp extends ConsumerStatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   ConsumerState<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends ConsumerState<MyApp> {
//   bool _isConnected = false;
//   String userType = '';
//   // final FirebaseMessagingService _firebaseMessagingService =
//   //     FirebaseMessagingService();

//   @override
//   void initState() {
//     // final NotificationFunction notificationFunction =
//     //     ref.read(notificationFunctionProvider);
//     // notificationFunction.initNotification();
//     // final paystackFunction = ref.read(paystackFunctionsProvider);
//     // paystackFunction.startPaystark();
//     // checkType();

//     super.initState();
//   }

//   Future<void> checkType() async {
//     final secureStorage = ref.read(secureStorageProvider);
//     final type = await secureStorage.readSecureData(AppConstants.authToken);
//     if (type != null) {
//       userType = type;
//     }
//   }

//   Widget decideNextPage(userType) {
//     if (userType == 'user') {
//       return const TabPage();
//     } else if (userType == 'admin') {
//       return const AdminTab();
//     } else {
//       return const AuthSignInScreen();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // ref.read(notificationFunctionProvider).uploadFcmToken();

//     // final internetProvider = ref.watch(internetStateProvider);

//     // Connectivity().onConnectivityChanged.listen((ConnectivityResult event) {
//     //   if (event == ConnectivityResult.none) {
//     //     ref.watch(internetStateProvider.notifier).state = false;
//     //   } else {
//     //     ref.watch(internetStateProvider.notifier).state = true;
//     //   }
//     // });

//     return StreamBuilder(
//         stream: Connectivity().onConnectivityChanged,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             switch (snapshot.data) {
//               case ConnectivityResult.none:
//                 return MaterialApp(
//                   home: Scaffold(
//                     appBar: AppBar(
//                       title: const MediumText(text: 'No Internet Connection'),
//                     ),
//                     body: Center(
//                       child: Container(
//                         color: Colors.grey,
//                         alignment: Alignment.center,
//                         child: const MediumText(text: 'No Internet Connection'),
//                       ),
//                     ),
//                   ),
//                 );
//               case ConnectivityResult.mobile:
//               case ConnectivityResult.wifi:
//                 return ResponsiveSizer(
//                   builder: (context, orientation, deviceType) {
//                     final User user = ref.watch(userProvider);

//                     Widget splash = AnimatedSplashScreen(
//                       animationDuration: const Duration(seconds: 1),
//                       duration: 3000,
//                       splash: Image.asset('images/splashScreen.png'),
//                       nextScreen: user.type == 'user'
//                           ? const TabPage()
//                           : const AdminTab(),
//                       splashTransition: SplashTransition.fadeTransition,
//                       //  pageTransitionType: PageTransitionType.scale,
//                       splashIconSize: 40.h,
//                       curve: Curves.easeIn,
//                     );

//                     return GetMaterialApp(
//                       theme: ThemeData(
//                         useMaterial3: true,
//                         brightness: Brightness.dark,
//                       ),
//                       debugShowCheckedModeBanner: false,
//                       home: ref.watch(getUserDataProvider).when(
//                         data: (Map<String, dynamic> data) {
//                           if (data.containsKey('off')) {
//                             return const AuthSignInScreen();
//                           } else {
//                             return splash;
//                           }
//                         },
//                         error: (obj, trace) {
//                           return const EmptyScreen();
//                         },
//                         loading: () {
//                           return const EmptyScreen();
//                         },
//                       ),
//                       getPages: getPages,
//                     );
//                   },
//                 );

//               default:
//                 return MaterialApp(
//                   home: Scaffold(
//                     appBar: AppBar(
//                       title: MediumText(text: 'Default'),
//                     ),
//                     body: Center(
//                       child: Container(
//                         color: Colors.grey,
//                         alignment: Alignment.center,
//                         child: MediumText(text: 'No Internet Connection1'),
//                       ),
//                     ),
//                   ),
//                 );
//             }
//           } else if (snapshot.hasError) {
//             return MaterialApp(
//               home: Scaffold(
//                 appBar: AppBar(
//                   title: const MediumText(text: 'Internet Error'),
//                 ),
//                 body: Center(
//                   child: Container(
//                     alignment: Alignment.center,
//                     child: const MediumText(
//                         text: 'Coud not verify internet availabiity'),
//                   ),
//                 ),
//               ),
//             );
//           } else {
//             return MaterialApp(
//               home: Scaffold(
//                 appBar: AppBar(
//                   title: const MediumText(text: 'No Internet Connection'),
//                 ),
//                 body: Center(
//                   child: Container(
//                     alignment: Alignment.center,
//                     child: const MediumText(text: 'No Internet Connection'),
//                   ),
//                 ),
//               ),
//             );
//           }
//         });
//   }
// }
// /////////////////////////////////////////////////////////////////////////////////////////////////

// // class NoInternetWidget extends ConsumerStatefulWidget {
// //   const NoInternetWidget({super.key});

// //   @override
// //   ConsumerState<NoInternetWidget> createState() => _NoInternetWidgetState();
// // }

// // class _NoInternetWidgetState extends ConsumerState<NoInternetWidget> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return 
// //   }
// // }
