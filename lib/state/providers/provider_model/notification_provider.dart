import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/models-classes/notifications.dart';

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, List<Notifications>>(
        (ref) => NotificationNotifier());

class NotificationNotifier extends StateNotifier<List<Notifications>> {
  NotificationNotifier() : super(<Notifications>[]);

  updateNotificationFromMapList(value) {
    List<Notifications> notifications = [];
    for (var element in value) {
      final notification = Notifications.fromMap(element);
      notifications.add(notification);
    }
    state = notifications;
  }

  updateNotification(List<Notifications> value) {
    state = value;
  }
}


// You asked for the house in the church