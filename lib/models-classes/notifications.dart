import 'dart:convert';

class Notifications {
  final String image;
  final String title;
  final String message;
  final String action;
  Notifications({
    required this.image,
    required this.title,
    required this.message,
    required this.action,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'title': title,
      'message': message,
      'action': action,
    };
  }

  factory Notifications.fromMap(Map<String, dynamic> map) {
    return Notifications(
      image: map['image'] as String,
      title: map['title'] as String,
      message: map['message'] as String,
      action: map['action'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notifications.fromJson(String source) =>
      Notifications.fromMap(json.decode(source) as Map<String, dynamic>);

  Notifications copyWith({
    String? image,
    String? title,
    String? message,
    String? action,
  }) {
    return Notifications(
      image: image ?? this.image,
      title: title ?? this.title,
      message: message ?? this.message,
      action: action ?? this.action,
    );
  }
}
