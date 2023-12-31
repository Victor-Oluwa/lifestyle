import 'dart:developer';
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/fonts/lifestyle_fonts.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:socket_io_client/socket_io_client.dart' as suk;

import '../../../../Common/strings/strings.dart';
import '../../../../Common/widgets/lifestyle_card.dart';
import '../../../../Common/widgets/medium_text.dart';
import '../../../../state/providers/actions/provider_operations.dart';
import '../../../../state/providers/provider_model/notification_provider.dart';
import '../../../../state/providers/provider_model/user_provider.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  late suk.Socket socket;
  String userid = "";

  @override
  void initState() {
    super.initState();
    socket = suk.io(
      uri,
      suk.OptionBuilder().setTransports(['websocket']).build(),
    );
    ref.read(notificationFunctionProvider).uploadFcmToken();
    ref.read(homeFunctionProvider).getNotifications();
  }

  @override
  void didChangeDependencies() {
    final notifyProvider = ref.watch(notificationProvider);
    ref.read(notificationFunctionProvider).uploadFcmToken();

    socket.onConnect((data) {
      log('Socket connected');
      socket.on('notifi_cations', (data) {
        if (data != null) {
          final userId = ref.read(userProvider).id;
          data.forEach((noti) {
            if (noti['userId'] == userId) {
              if (!notifyProvider.contains(noti)) {
                ref
                    .read(notificationProvider.notifier)
                    .updateNotificationFromMapList(data);
              }
            }
          });
        }
      });
    });

    socket.connect();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
    socket.onDisconnect((data) => log('Socket disconnected'));
  }

  @override
  Widget build(BuildContext context) {
    final notifyProvider = ref.watch(notificationProvider);

    // log('Notification from provider $notification');
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10.h,
        elevation: 0,
        backgroundColor: LifestyleColors.kTaupeBackground,
        title: Neumorphic(
          padding: EdgeInsets.all(15.sp),
          style: NeumorphicStyle(
            depth: -1,
            color: LifestyleColors.kTaupeBackground,
          ),
          child: NeumorphicText(
            textStyle: NeumorphicTextStyle(
              fontFamily: LifestyleFonts.kComorantBold,
              fontSize: 20.sp,
            ),
            style: NeumorphicStyle(
              depth: 1,
              intensity: 20,
              color: LifestyleColors.kTaupeBackground,
            ),
            'NOTIFICATIONS',
          ),
        ),
      ),
      backgroundColor: LifestyleColors.kTaupeBackground,
      body: SafeArea(
        child: Container(
          child: ListView.builder(
              itemCount: notifyProvider.length,
              // itemCount: 25,
              itemBuilder: (context, index) {
                final notification = notifyProvider[index];

                return Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      alignment: Alignment.center,
                      child: LifestyleCard(
                        cardWidth: 85.w,
                        cardChild: ListTile(
                          title: MediumText(
                            size: 17.sp,
                            text: notification.title,
                          ),
                          subtitle: MediumText(
                            text: notification.preview,
                            overflow: TextOverflow.visible,
                            align: TextAlign.left,
                            color: LifestyleColors.black.withOpacity(0.4),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: LifestyleColors.transparent,
                            radius: 17.sp,
                            child: Image(
                                image: AssetImage(
                                    LifestyleStrings.whiteLogoImage)),
                          ),
                          trailing:
                              MediumText(text: DateTime.now().year.toString()),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 9.5.w,
                      top: 2.h,
                      child: Container(
                        height: 1.h,
                        width: 1.h,
                        decoration: BoxDecoration(
                            color: notification.read
                                ? LifestyleColors.black.withOpacity(0.4)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20.sp)),
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
