import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Common/colors/lifestyle_colors.dart';
import '../provider/auth_provider.dart';

class InitScreen extends ConsumerStatefulWidget {
  const InitScreen({super.key});

  @override
  ConsumerState<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends ConsumerState<InitScreen> {
  @override
  void didChangeDependencies() {
    final authFunction = ref.watch(authFunctionsProvider(context));

    authFunction.checkConnection().then((isConnected) {
      authFunction.shouldShowDialog.call(
        internetAccess: isConnected,
        context: context,
      );
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    log('Got to Init scren');
    return Scaffold(
      backgroundColor: LifestyleColors.kTaupeBackground,
      body: Center(
          child: Container(
        height: 20.h,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'images/toplogo.png',
            ),
          ),
        ),
      )),
    );
  }
}
