import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lifestyle/Common/strings/strings.dart';
import 'package:lifestyle/Common/widgets/floating_text_editor.dart';
import 'package:lifestyle/state/providers/provider_model/notification_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/widgets/custom_textfield.dart';
import 'package:lifestyle/common/widgets/medium_text.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';

import 'select_action_screen.dart';

class Announcement extends ConsumerStatefulWidget {
  const Announcement({super.key});

  @override
  ConsumerState<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends ConsumerState<Announcement> {
  @override
  void didChangeDependencies() {
    ref.read(notificationFunctionProvider).uploadFcmToken();

    final notificationFunction = ref.read(notificationFunctionProvider);
    notificationFunction.invalidateNotificationActionsProviders(ref);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    titleController.dispose();
    messageController.dispose();
    urlController.dispose();
    previewController.dispose();
    titleFocusNode.dispose();
    previewFocusNode.dispose();
    messageFocusNode.dispose();

    super.dispose();
  }

  FocusNode titleFocusNode = FocusNode();
  FocusNode previewFocusNode = FocusNode();
  FocusNode messageFocusNode = FocusNode();

  @override
  void initState() {
    titleFocusNode.addListener(() {
      setState(() {});
    });
    previewFocusNode.addListener(() {
      setState(() {});
    });
    messageFocusNode.addListener(() {
      setState(() {});
    });
    titleController = TextEditingController();
    messageController = TextEditingController();
    urlController = TextEditingController();
    previewController = TextEditingController();
    _notificationFormKey = GlobalKey<FormState>();

    super.initState();
  }

  late TextEditingController titleController;
  late TextEditingController messageController;
  late TextEditingController urlController;
  late TextEditingController previewController;

  late GlobalKey<FormState> _notificationFormKey;

  @override
  Widget build(BuildContext context) {
    final notifyProvider = ref.watch(notificationProvider);

    log('Notification list: B: $notifyProvider');
    log('Notification length: B: ${notifyProvider.length}');

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
            color: LifestyleColors.white, text: LifestyleStrings.announcement),
        actions: [
          Column(
            children: [
              IconButton(
                  onPressed: () async {
                    // final image = ref.read(notificationImageProvider);
                    final action = ref.read(selectedActionProvider);
                    final actionData = ref.read(selectedActionValueProvider);

                    if (_notificationFormKey.currentState!.validate()) {
                      log('Validated');
                      notificationFunction.sendNotification(
                          actionData: actionData,
                          preview: previewController.text,
                          action: action,
                          title: titleController.text,
                          message: messageController.text);
                    }

                    // await ref.read(homeFunctionProvider).getNotifications();
                  },
                  icon: const Icon(Icons.send)),
              const MediumText(
                text: LifestyleStrings.announcementSendText,
                color: LifestyleColors.white,
              ),
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
              height: 2.h,
            ),
            buildSignUpForm(),
            SizedBox(
              height: 5.h,
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
                          color: LifestyleColors.white, text: selectedAction),
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
    );
  }

  Form buildSignUpForm() {
    return Form(
      key: _notificationFormKey,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 4.h,
            ),
            FloatingTextEditor(
              focusNode: titleFocusNode,
              controller: titleController,
              maxLine: 1,
              label: const MediumText(text: 'Title'),
              validate: (val) {
                if (val!.length < 5) {
                  return 'Title length is less then 5';
                } else if (val.isEmpty) {
                  return 'Title text cannot be empty';
                } else if (val.length > 500) {
                  return 'Title length is more than 500';
                }

                return null;
              },
            ),
            SizedBox(
              height: 4.h,
            ),
            FloatingTextEditor(
              focusNode: previewFocusNode,
              controller: previewController,
              label: const MediumText(text: 'Preview'),
              maxLine: 1,
              validate: (val) {
                if (val!.length < 10) {
                  return 'Preview length is less then 10';
                } else if (val.isEmpty) {
                  return 'Preview text cannot be empty';
                } else if (val.length > 1000) {
                  return 'Preview length is more than 1000';
                }

                return null;
              },
            ),
            SizedBox(
              height: 4.h,
            ),
            FloatingTextEditor(
              maxLine: 5,
              focusNode: messageFocusNode,
              controller: messageController,
              label: const MediumText(text: 'Message'),
              validate: (val) {
                if (val!.length < 10) {
                  return 'Message length is less then 10';
                } else if (val.isEmpty) {
                  return 'Message cannot be empty';
                } else if (val.length > 5000) {
                  return 'Message length is more than 5000';
                }

                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
