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
      // phone: map['phone']?.toInt() ?? 0,
      phone: map['phone'] ?? '0',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      fcmToken: map['fcmToken'] ?? '',
      picture: map['picture'] ?? '',
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map((x) => Map<String, dynamic>.from(x)),
      ),
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
      cart: cart ?? this.cart,
    );
  }
}
