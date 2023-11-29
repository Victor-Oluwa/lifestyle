  // Widget splash = AnimatedSplashScreen(
        //   animationDuration: const Duration(seconds: 1),
        //   duration: 3000,
        //   splash: Image.asset('images/splashScreen.png'),
        //   nextScreen: user.type == 'user' ? const TabPage() : const AdminTab(),
        //   splashTransition: SplashTransition.fadeTransition,
        //   //  pageTransitionType: PageTransitionType.scale,
        //   splashIconSize: 40.h,
        //   curve: Curves.easeIn,
// );
        







    // ref.read(notificationFunctionProvider).uploadFcmToken();

    // final internetProvider = ref.watch(internetStateProvider);

    // Connectivity().onConnectivityChanged.listen((ConnectivityResult event) {
    //   if (event == ConnectivityResult.none) {
    //     ref.watch(internetStateProvider.notifier).state = false;
    //   } else {
    //     ref.watch(internetStateProvider.notifier).state = true;
    //   }
    // });
    // Future<void> checkInternet() async {
    //   var connectivityResult = await (Connectivity().checkConnectivity());
    //   if (connectivityResult == ConnectivityResult.none) {
    //     log('No connection');
    //   } else if (connectivityResult == ConnectivityResult.wifi) {
    //     myHome = TabPage();
    //   }
    //   // return connectivityResult;
    // }



      // Future<void> checkType() async {
  //   final secureStorage = ref.read(secureStorageProvider);
  //   final type = await secureStorage.readSecureData(AppConstants.authToken);
  //   if (type != null) {
  //     userType = type;
  //   }
  // }

  // Widget decideNextPage(userType) {
  //   if (userType == 'user') {
  //     return const TabPage();
  //   } else if (userType == 'admin') {
  //     return const AdminTab();
  //   } else {
  //     return const AuthSignInScreen();
  //   }
  // }



  // await checkConnection().then((connected) {
                    //   log('The truth: $connected');
                    //   if (connected == true) {
                    //     log('User is connected');
                    //     processUserData();
                    //   }
                    //   log('User is not connected');
                    // });


  //                    Widget processUserData(splash) {
  //   return ref.watch(getUserDataProvider).when(
  //     data: (Map<String, dynamic> data) {
  //       if (data.containsKey('off')) {
  //         return const AuthSignInScreen();
  //       } else {
  //         return const InitScreen();
  //       }
  //     },
  //     error: (obj, trace) {
  //       return const InitScreen();
  //     },
  //     loading: () {
  //       return const InitScreen();
  //     },
  //   );
  // }