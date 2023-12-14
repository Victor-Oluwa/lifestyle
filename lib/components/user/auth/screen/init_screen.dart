import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/strings/strings.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
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
    ref.read(notificationFunctionProvider).uploadFcmToken();
    final authFunction = ref.watch(authFunctionsProvider(context));

    log('message');

    authFunction.checkConnection().then((isConnected) {
      authFunction.usherUser.call(
        internetAccess: isConnected,
        context: context,
      );
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LifestyleColors.kTaupeBackground,
      body: Center(
          child: Container(
        height: 20.h,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              LifestyleAssetImages.whiteLogoImage,
            ),
          ),
        ),
      )),
    );
  }
}
