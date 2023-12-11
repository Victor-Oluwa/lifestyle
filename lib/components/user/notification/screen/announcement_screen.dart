import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lifestyle/Common/widgets/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/widgets/custom_textfield.dart';
import 'package:lifestyle/common/widgets/medium_text.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:socket_io_client/socket_io_client.dart' as suk;

import 'select_action_screen.dart';

class Announcement extends ConsumerStatefulWidget {
  const Announcement({super.key});

  @override
  ConsumerState<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends ConsumerState<Announcement> {
  late suk.Socket socket;
  String userid = "";
  List notifications = [];

  @override
  void initState() {
    super.initState();

    ref.read(notificationFunctionProvider).uploadFcmToken();
    socket = suk.io(
      'http://192.168.8.1:3000',
      suk.OptionBuilder().setTransports(['websocket']).build(),
    );
    socket.onConnect((data) {
      log('Socket connected');
      socket.on('notifi_cations', (data) {
        log('Got the new notification here: $data');
        setState(() {
          if (data != null) {
            notifications.add(data);
          }
        });
      });
    });

    socket.connect();
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    urlController.dispose();

    super.dispose();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  final _titleFormKey = GlobalKey<FormState>();
  final _bodyFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    log('Notification list: $notifications');

    final notificationFunction = ref.read(notificationFunctionProvider);
    final selectedAction = ref.watch(selectedActionProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFB0A291),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 10.h,
        centerTitle: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: const MediumText(
            color: LifestyleColors.white, text: 'ANNOUNCEMENT'),
        actions: [
          Column(
            children: [
              IconButton(
                  onPressed: () async {
                    print('Notification list: $notifications');

                    final image = ref.read(notificationImageProvider);
                    final action = notificationFunction.getNotificationAction(
                        selectedAction: selectedAction, ref: ref);
                    notificationFunction.sendNotification(
                        titleFormKey: _titleFormKey,
                        bodyFormKey: _bodyFormKey,
                        image: image,
                        action: action,
                        title: titleController.text,
                        body: bodyController.text);
                  },
                  icon: const Icon(Icons.send)),
              const MediumText(
                text: 'Send',
                color: LifestyleColors.white,
              )
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 3.h,
            ),
            Container(
              margin: EdgeInsets.only(left: 3.w, right: 3.w),
              child: MediumText(
                text: 'Send a',
                size: 25.sp,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 3.w, right: 3.w),
              child: MediumText(
                text: 'Notification',
                size: 25.sp,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              margin: EdgeInsets.only(left: 3.w, right: 3.w),
              child: Form(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        final image = await notificationFunction
                            .pickNotificationImageFile();
                        ref.read(notificationImageProvider.notifier).state =
                            image;
                      },
                      child: DottedBorder(
                        child: Container(
                          padding: EdgeInsets.all(1.h),
                          width: double.infinity,
                          height: 25.h,
                          child: const MediumText(text: 'Add Image'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextField(
                      key: _titleFormKey,
                      controller: titleController,
                      label: 'Title',
                      hintText: 'Add a title',
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextField(
                      key: _bodyFormKey,
                      maxLines: 10,
                      controller: bodyController,
                      label: 'Body',
                      hintText: 'Add a body',
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      color: LifestyleColors.kTaupeDark.withOpacity(0.5),
                      // height: 5.h,
                      padding: EdgeInsets.all(1.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.line_style),
                              SizedBox(
                                width: 1.w,
                              ),
                              const MediumText(
                                  color: LifestyleColors.white,
                                  text: 'Call to action:'),
                              SizedBox(
                                width: 3.w,
                              ),
                              MediumText(
                                  color: LifestyleColors.white,
                                  text: selectedAction.isEmpty
                                      ? 'Not set'
                                      : selectedAction),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              Get.to(() => const SelectActionScreen());
                            },
                            icon: const MediumText(
                              text: 'Edit',
                              color: LifestyleColors.white,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
    );
  }
}
