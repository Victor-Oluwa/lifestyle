import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lifestyle/components/user/ar/screen/ar_blank_page.dart';
import 'package:lifestyle/components/user/profile/screens/user_details_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/routes-management/lifestyle_routes.dart';
import 'components/user/auth/screen/init_screen.dart';
import 'core/utils/screen_utils.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    ScreenUtils.init(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
          debugShowCheckedModeBanner: false,
          home: const InitScreen(),
          // home: const UserDetailsScreen(),

          getPages: getPages,
        );
      },
    );
  }
}
