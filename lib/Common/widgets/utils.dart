import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import 'medium_text.dart';

import 'package:flutter/material.dart';

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}

void dropperMessage(String title, String text,
    {Duration duration = const Duration(seconds: 5)}) {
  Get.snackbar(
    title,
    text,
    colorText: Colors.white,
    duration: duration,
  );
}

Future<List<File>> pickImage() async {
  List<File> image = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        image.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return image;
}

Future<List<File>> pickModel() async {
  List<File> models = [];

  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        models.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return models;
}

SnackbarController showBottomSnackBar(
    {required String message, required String title}) {
  return Get.showSnackbar(GetSnackBar(
    titleText: MediumText(text: title),
    messageText: MediumText(text: message),
    backgroundColor: Colors.black,
    duration: const Duration(seconds: 5),
    title: title,
    message: message,
  ));
}

// final messangerKey = GlobalKey<ScaffoldMessengerState>();
//   messangerKey.currentState?.showSnackBar(
//     SnackBar(
//       content: Text(text),
//     ),
//   );
