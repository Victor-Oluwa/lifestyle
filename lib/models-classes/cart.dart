// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'product.dart';

class Cart {
  final String id;
  final Product product;
  final int quantity;
  Cart({
    required this.id,
    required this.product,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] ?? '',
      product: Product.fromMap(map['product']),
      quantity: map['quantity'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) =>
      Cart.fromMap(json.decode(source) as Map<String, dynamic>);

  Cart copyWith({
    String? id,
    Product? product,
    int? quantity,
  }) {
    return Cart(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
