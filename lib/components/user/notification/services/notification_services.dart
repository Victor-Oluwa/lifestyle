import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:lifestyle/Common/widgets/utils.dart';
import 'package:lifestyle/core/error/exception/api_exception.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart' as x;
import 'package:lifestyle/state/providers/provider_model/user_provider.dart';
import 'package:http/http.dart' as http;

import '../../../../common/widgets/error_handling.dart';
import '../../../../models-classes/user.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log('Title: ${message.notification?.title}');
  log('Body: ${message.notification?.body}');
  log('Payload: ${message.data}');
}

class NotificationServices {
  NotificationServices({required this.ref, required this.firebaseMessaging});
  final Ref ref;
  final FirebaseMessaging firebaseMessaging;

  dynamic tokenFCM = '';
  // List<User> allUsers = [];
  // List<String> allFCMToken = [];

  final AndroidNotificationChannel _androidChannel =
      const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  final _localNotification = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // x.Get.to(() => const NewProductsScreen(), arguments: message);
  }

  initLocalNotification() async {
    const DarwinInitializationSettings iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _localNotification.initialize(settings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
      final message = RemoteMessage.fromMap(jsonDecode(response.payload!));
      handleMessage(message);
    });

    final platform = _localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((event) {
      final notification = event.notification;
      if (notification == null) return;

      _localNotification.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
                _androidChannel.id, _androidChannel.name,
                channelDescription: _androidChannel.description,
                icon: '@drawable/ic_launcher'),
          ),
          payload: jsonEncode(event.toMap()));
    });
  }

  uploadFcmToken({required String fcmToken, required String email}) async {
    try {
      final dio = Dio();
      Response res = await dio.post('$uri/admin/add/fcmtoken',
          options: Options(
            contentType: Headers.jsonContentType,
          ),
          data: {
            'fcmToken': fcmToken,
            'email': email,
          });

      if (res.statusCode == 200 || res.statusCode == 201) {
        log('FCM token updated');
      } else {
        throw APIException(
            message: res.data, statusCode: res.statusCode ?? 100);
      }
    } on APIException catch (e) {
      log(
        'User FCM token was not updated: ${e.statusCode} error: ${e.message}',
      );
    } catch (e) {
      log('Failed to update FCM token: $e');
    }
  }

  Future<void> initNotification() async {
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    try {
      tokenFCM = await firebaseMessaging.getToken();
    } catch (e) {
      log('Failed to get cloud messaging token: $e');
    }
    initPushNotification();
    initLocalNotification();
  }

  Future<List<User>> getUsers() async {
    return await fetchAllUsers();
  }

  Future<List<User>> fetchAllUsers() async {
    List<User> userList = [];
    try {
      final User user = ref.read(userProvider);
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-users'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        AppConstants.authToken: user.token,
      });
      httpErrorHandling(
          response: res,
          onSuccess: () {
            for (int p = 0; p < jsonDecode(res.body).length; p++) {
              userList.add(
                User.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[p],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      dropperMessage('Something went wrong',
          'Check your internet connection and restart the app');
      log('Error: Could not get product');
    }
    return userList;
  }

  String generateRandomString(int length) {
    final random = math.Random();
    const availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(length,
            (index) => availableChars[random.nextInt(availableChars.length)])
        .join();
    return randomString;
  }

  Future<String> getNotificationImageUrl(
      {required String title, required File image}) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    final String imageId = generateRandomString(7);

    final Reference ref =
        storage.ref().child('Notifications/$title/image/$imageId');
    final UploadTask task = ref.putFile(File(image.path));
    final TaskSnapshot snapshot =
        await task.whenComplete(() => log('Image Uploaded'));
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> sendNotification(
      {required String title,
      required String preview,
      required String body,
      required String action,
      required String actionData}) async {
    final users = await getUsers();
    final List<String> userIds = users.map((user) => user.id).toList();

    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(
        Uri.parse('$uri/send-notification'),
        headers: headers,
        body: jsonEncode({
          'userIds': userIds,
          'title': title,
          'preview': preview,
          'body': body,
          'read': false,
          'action': action,
          'actionData': actionData,
        }),
      );
      if (response.statusCode == 200) {
        x.Get.showSnackbar(const x.GetSnackBar(
          duration: Duration(seconds: 4),
          backgroundColor: Colors.black,
          message: 'Notifications sent successfully!',
        ));
      } else {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
    } on APIException catch (e) {
      dropperMessage('Attention', 'An error occured. Please try again later');
      log('Notification error ${e.statusCode} Error: ${e.message}');
    } catch (e) {
      dropperMessage('Attention', 'An error occured. Please try again later');
      log('Notification error: $e');
    }
  }
}
