import 'dart:convert';

class Notifications {
  final String image;
  final String userId;
  final String title;
  final String preview;
  final String message;
  final int date;
  final String actionData;

  final String action;
  final bool read;
  Notifications({
    required this.userId,
    required this.image,
    required this.title,
    required this.preview,
    required this.message,
    required this.date,
    required this.action,
    required this.actionData,
    required this.read,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'image': image,
      'title': title,
      'preview': preview,
      'message': message,
      'action': action,
      'actionData': actionData,
      'date': date,
      'read': read,
    };
  }

  factory Notifications.fromMap(Map<String, dynamic> map) {
    return Notifications(
      userId: map['userId'] ?? '',
      image: map['image'] ?? '',
      title: map['title'] ?? '',
      preview: map['preview'] ?? '',
      message: map['message'] ?? '',
      date: map['date']?.toInt() ?? 0,
      action: map['action'] ?? '',
      actionData: map['actionData'] ?? '',
      read: map['read'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notifications.fromJson(String source) =>
      Notifications.fromMap(json.decode(source) as Map<String, dynamic>);

  Notifications copyWith({
    String? userId,
    String? image,
    String? title,
    String? preview,
    String? message,
    int? date,
    String? action,
    String? actionData,
    bool? read,
  }) {
    return Notifications(
      userId: userId ?? this.userId,
      image: image ?? this.image,
      title: title ?? this.title,
      preview: preview ?? this.preview,
      message: message ?? this.message,
      date: date ?? this.date,
      action: action ?? this.action,
      actionData: action ?? this.actionData,
      read: read ?? this.read,
    );
  }
}
