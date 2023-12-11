import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lifestyle/components/user/notification/screen/demo_noti.dart';
import 'package:lifestyle/components/user/notification/screen/user_notification.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/routes-management/lifestyle_routes.dart';
import 'components/user/auth/screen/init_screen.dart';
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

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
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
          // home: const DemoNoti(),

          getPages: getPages,
        );
      },
    );
  }
}
