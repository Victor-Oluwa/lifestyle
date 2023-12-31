import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/strings/strings.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:lifestyle/state/providers/provider_model/user_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:socket_io_client/socket_io_client.dart' as suk;

import '../../../../Common/colors/lifestyle_colors.dart';
import '../../../../Common/widgets/app_constants.dart';
import '../provider/auth_provider.dart';

final notificationListProvider = StateProvider((ref) => []);

class InitScreen extends ConsumerStatefulWidget {
  const InitScreen({super.key});

  @override
  ConsumerState<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends ConsumerState<InitScreen> {
  late suk.Socket socket;
  String userid = "";
  // List notifications = [];

  @override
  void initState() {
    ref.read(notificationFunctionProvider).uploadFcmToken();
    // final user = ref.read(userProvider);
    // log('User: ${user.id}');
    // socket = suk.io(
    //   uri,
    //   suk.OptionBuilder().setTransports(['websocket']).build(),
    // );
    // socket.onConnect((data) {
    //   log('Socket connected at init');
    //   socket.on('notifi_cations', (data) {
    //     log('Notificating updated');
    //     if (data != null) {
    //       final notifications = ref.read(notificationListProvider.notifier);
    //       notifications.state = data;
    //       log(notifications.toString());
    //     }
    //   });
    // });

    // socket.connect();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    ref.read(notificationFunctionProvider).uploadFcmToken();
    final authFunction = ref.watch(authFunctionsProvider(context));

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
              LifestyleStrings.whiteLogoImage,
            ),
          ),
        ),
      )),
    );
  }
}
