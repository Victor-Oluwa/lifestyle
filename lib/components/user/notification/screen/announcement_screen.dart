import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/widgets/custom_textfield.dart';
import 'package:lifestyle/common/widgets/medium_text.dart';
import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Announcement extends ConsumerWidget {
  const Announcement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController titleController = TextEditingController();
    TextEditingController bodyController = TextEditingController();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 0,
        onPressed: () {
          final notificationFunction = ref.read(notificationFunctionProvider);
          notificationFunction.sendNotification(
              title: titleController.text, body: bodyController.text);
        },
        child: const Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color(0xFFB0A291),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: const MediumText(text: 'ANNOUNCEMENT'),
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
              height: 10.h,
            ),
            Container(
              margin: EdgeInsets.only(left: 3.w, right: 3.w),
              child: Form(
                child: Column(
                  children: [
                    CustomTextField(
                      controller: titleController,
                      label: 'Title',
                      hintText: 'Add a title',
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextField(
                      maxLines: 10,
                      controller: bodyController,
                      label: 'Body',
                      hintText: 'Add a body',
                    ),
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
