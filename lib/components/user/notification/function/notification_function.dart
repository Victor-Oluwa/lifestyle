import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/Common/widgets/utils.dart';
import 'package:lifestyle/components/user/notification/services/notification_services.dart';
import 'package:lifestyle/core/connectivity/provider/connectivity_provider.dart';

import '../../../../models-classes/user.dart';
import '../../../../state/providers/actions/provider_operations.dart';
import '../../../../state/providers/provider_model/user_provider.dart';
import '../screen/select_action_screen.dart';

class NotificationFunction {
  NotificationFunction({required this.firebaseMessaging, required this.ref});
  final Ref ref;
  final FirebaseMessaging firebaseMessaging;

  NotificationServices getNotificationServices() {
    return ref.read(notificationServicesProvider);
  }

  Future<List<User>> getUsers() async {
    final adminServices = ref.read(notificationServicesProvider);
    return await adminServices.fetchAllUsers();
  }

  uploadFcmToken() async {
    final connectivity = ref.read(connectivityServiceProvider);
    final status = await connectivity.checkInternetConnection();
    if (status == false) {
      log('Could not update FCM toked: No Internet Connection');
    } else {
      final adminServices = ref.read(notificationServicesProvider);
      final user = ref.read(userProvider);
      String? tokenFCM = '';
      try {
        tokenFCM = await firebaseMessaging.getToken();
      } catch (e) {
        log('Failed to get cloud messaging token: $e');
      }

      if (tokenFCM != null) {
        await adminServices.uploadFcmToken(
            fcmToken: tokenFCM, email: user.email);
      }
    }
  }

  Future<File> pickNotificationImageFile() async {
    final imageFile = await pickSingleImage();
    return imageFile;
  }

  String getNotificationAction(
      {required String selectedAction, required WidgetRef ref}) {
    switch (selectedAction) {
      case 'Navigate':
        return ref.read(navigateValueProvider);
      case 'Launch Url':
        return ref.read(launchUrlValueProvider);
      case 'No call to action':
        return 'false';
      case 'Not set':
        return 'false';
      default:
        return 'false';
    }
  }

  Future<void> sendNotification(
      {required String title,
      required String preview,
      required String message,
      required String action,
      required String actionData}) async {
    final notificationServices = getNotificationServices();

    return notificationServices.sendNotification(
      actionData: actionData,
      title: title,
      preview: preview,
      body: message,
      action: action,
    );
  }

  initNotification() async {
    final notificationServices = getNotificationServices();
    return await notificationServices.initNotification();
  }

  invalidateNotificationActionsProviders(WidgetRef ref) {
    ref.invalidate(selectedActionProvider);
    ref.invalidate(selectedActionValueProvider);
    ref.invalidate(navigateValueProvider);
    ref.invalidate(launchUrlValueProvider);
  }
}
