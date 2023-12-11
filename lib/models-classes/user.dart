import 'dart:convert';

class User {
  final String id;
  final String name;
  final String password;
  final String email;
  final String address;
  final String phone;
  final String type;
  final String token;
  final String fcmToken;
  final String picture;
  final List<dynamic> notifications;
  final List<dynamic> cart;

  User(
      {required this.id,
      required this.name,
      required this.password,
      required this.email,
      required this.address,
      this.phone = '',
      required this.type,
      required this.token,
      this.fcmToken = '',
      required this.picture,
      this.notifications = const [],
      required this.cart});

  User.empty()
      : this(
            id: 'id.empty',
            name: 'name.empty',
            password: 'password.empty',
            email: 'email.empty',
            address: 'address.empty',
            phone: 'address.empty',
            type: 'empty.type',
            token: 'empty.token',
            fcmToken: 'empty.fcmToken',
            picture: 'empty.picture',
            notifications: [],
            cart: []);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'email': email,
      'address': address,
      'phone': phone,
      'type': type,
      'token': token,
      'fcmToken': fcmToken,
      'cart': cart,
      'notifications': notifications,
      'picture': picture,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '0',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      fcmToken: map['fcmToken'] ?? '',
      picture: map['picture'] ?? '',
      /* In this code, map['cart']?.map((cartItem) => Map<String, dynamic>.from(cartItem)) 
      checks if the map contains a key cart. 
      If it does, it uses the map method to transform each item in the list into a map. */
      cart: List<Map<String, dynamic>>.from(
          map['cart']?.map((cartItem) => Map<String, dynamic>.from(cartItem))),
      notifications: List<Map<String, dynamic>>.from(
          map['notifications']?.map((item) => Map<String, dynamic>.from(item))),
    );
  }
  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
  User copyWith({
    String? id,
    String? name,
    String? password,
    String? email,
    String? address,
    String? phone,
    String? type,
    String? token,
    String? picture,
    String? fcmToken,
    List<dynamic>? cart,
    List<dynamic>? notifications,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      type: type ?? this.type,
      token: token ?? this.token,
      fcmToken: fcmToken ?? this.fcmToken,
      picture: picture ?? this.picture,
      notifications: notifications ?? this.notifications,
      cart: cart ?? this.cart,
    );
  }
}
