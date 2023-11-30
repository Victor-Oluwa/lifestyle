// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../../Common/colors/lifestyle_colors.dart';
import '../../../../core/typeDef/type_def.dart';
import '../../../../state/providers/actions/provider_operations.dart';
import '../../../../state/providers/provider_model/user_provider.dart';
import '../../../admin/admin-tab/admin_tab.dart';
import '../../home/screens/tab_page.dart';
import '../provider/auth_provider.dart';
import '../screen/login.dart';
import '../screen/signup.dart';

class AuthFunction {
  AuthFunction({required this.chiefContext, required this.ref});
  final Ref ref;
  final BuildContext chiefContext;

  Future<void> shouldShowDialog(
      {required bool internetAccess, required BuildContext context}) async {
    if (!internetAccess) {
      Future.delayed(const Duration(seconds: 5), () {
        showDialog(
          barrierDismissible: false,
          barrierColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              surfaceTintColor: LifestyleColors.kTaupeDarkened,
              title: const Text('No Internet Connection'),
              content: const Text('Connect to the internet and try again'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Retry'),
                  onPressed: () async {
                    Navigator.pop(context);
                    await checkConnection().then((isConnected) {
                      shouldShowDialog.call(
                          internetAccess: isConnected, context: chiefContext);
                    });

                    // await recallDialogBox();
                  },
                ),
              ],
            );
          },
        );
      });
    } else {
      await confirmUserRole();
    }
  }

  Future<void> confirmUserRole() async {
    try {
      final userStatus = await authenticateUser();
      final user = ref.watch(userProvider);

      log('User status: $userStatus');

      if (userStatus.containsKey('off')) {
        Get.offAll(const LoginScreen());
      } else {
        switch (user.type) {
          case 'user':
            log('User Type: ${user.type}');

            Get.offAll(() => const TabPage());
            break;
          case 'admin':
            log('User Type: ${user.type}');
            Get.offAll(() => const AdminTab());
            break;
          default:
            log('User Type: ${user.type}');
            Get.offAll(() => const SignUpScreen());
        }
      }
    } catch (e) {
      log('[AuthFunctions] Lifestyle failed to authenticate user: $e');
    }
  }

  Future<bool> checkConnection() async {
    final authService = ref.read(authServiceProvider);
    return await authService.checkInternetConnection();
  }

  Future<Map<String, dynamic>> authenticateUser() async {
    return await ref.watch(getUserDataProvider.future);
  }

  void signUpUser({
    required TEC emailController,
    required TEC passwordController,
    required TEC nameController,
  }) async {
    final authServices = ref.read(authServiceProvider);
    await authServices
        .signUpUser(
          email: emailController.text,
          password: passwordController.text,
          name: nameController.text,
        )
        .then(
          (value) async =>
              await ref.read(notificationFunctionProvider).uploadFcmToken(),
        );
  }
}
