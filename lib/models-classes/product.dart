import 'dart:convert';

// Double Used Here!
class Product {
  final String name;
  final String description;
  final int inStock;
  final int inCart;
  final double price;
  final String category;
  final List<String> images;
  final List<String> models;
  final String createdAt;
  final String status;
  final String id;
  Product({
    required this.name,
    required this.description,
    required this.inStock,
    required this.inCart,
    required this.price,
    required this.category,
    this.createdAt = '',
    required this.images,
    required this.models,
    this.status = 'Available',
    required this.id,
  });

  Product.empty()
      : this(
            name: 'name.empty',
            description: 'description.empty',
            inStock: 0,
            inCart: 0,
            price: 0.0,
            category: 'category.empty',
            images: [imageUrl],
            models: [imageUrl],
            createdAt: 'createdAt.empty',
            status: 'status.empty',
            id: 'id.empty');

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'inStock': inStock,
      'inCart': inCart,
      'price': price,
      'category': category,
      'createdAt': createdAt,
      'images': images,
      'models': models,
      'status': status,
      'id': id,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      inStock: map['inStock'] ?? 0,
      price: map['price']?.toDouble() ?? 0.0,
      category: map['category'] ?? '',
      createdAt: map['createdAt'] ?? '',
      images: List<String>.from(map['images']),
      models: List<String>.from(map['models']),
      status: map['status'] ?? '',
      id: map['_id'],
      inCart: map['inCart'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}

final imageUrl =
    'https://firebasestorage.googleapis.com/v0/b/lifestyle-ar-app.appspot.com/o/ALEXANDRIA%2Fimage%2FALEXANDRIA?alt=media&token=1310d999-1ea9-43b5-8655-41aaa7012302';
