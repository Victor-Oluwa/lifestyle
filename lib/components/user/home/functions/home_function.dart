import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/common/widgets/utils.dart';
import 'package:lifestyle/components/user/home/provider/home_provider.dart';
import 'package:lifestyle/routes-management/lifestyle_routes_names.dart';
import 'package:get/get.dart';
import 'package:lifestyle/state/providers/provider_model/notification_provider.dart';

class HomeFunction {
  final Ref ref;
  HomeFunction({required this.ref});

  void navigateToSearchScreen(String query) {
    if (query != '') {
      Get.toNamed(LifestyleRouteName.searchScreenRoute, arguments: query);
    } else {
      dropperMessage('ERROR', 'Text field is empty!');
    }
  }

  void navigateToCartScreen() {
    Get.toNamed(LifestyleRouteName.cartRoute);
  }

  void navigateToNotifications() {
    Get.toNamed(LifestyleRouteName.notificationsRoute);
  }

  Future<void> getNotifications() async {
    final homeSeervices = ref.read(homeServiceProvider);
    await homeSeervices.getNotifications();
  }
}
