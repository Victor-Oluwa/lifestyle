import 'dart:convert';

import 'package:lifestyle/models-classes/product.dart';

class Order {
  final String id;
  final String customerName;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final int orderTime;
  final int status;
  final double totalPrice;
  final bool paid;
  Order(
      {required this.id,
      required this.customerName,
      required this.products,
      required this.quantity,
      required this.address,
      required this.userId,
      required this.orderTime,
      required this.status,
      required this.paid,
      required this.totalPrice});

  Order.empty()
      : this(
            id: 'empty.id',
            customerName: 'empty.customerName',
            products: const [],
            quantity: const [],
            address: 'empty.address',
            userId: 'empty.userId',
            orderTime: 0,
            status: 0,
            paid: false,
            totalPrice: 0.0);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'orderTime': orderTime,
      'status': status,
      'paid': paid,
      'totalPrice': totalPrice,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      products: List<Product>.from(
          map['products']?.map((x) => Product.fromMap(x['product']))),
      quantity: List<int>.from(
        map['products']?.map(
          (product) => product['quantity'],
        ),
      ),
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      customerName: map['customerName'] ?? '',
      orderTime: map['orderTime']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      paid: map['paid'] ?? false,
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());
  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
  Order copyWith({
    String? id,
    List<Product>? products,
    List<int>? quantity,
    String? address,
    String? userId,
    int? orderTime,
    bool? paid,
    int? status,
    double? totalPrice,
    String? customerName,
  }) {
    return Order(
      id: id ?? this.id,
      paid: paid ?? this.paid,
      customerName: customerName ?? this.customerName,
      products: products ?? this.products,
      quantity: quantity ?? this.quantity,
      address: address ?? this.address,
      userId: userId ?? this.userId,
      orderTime: orderTime ?? this.orderTime,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
