import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductCategory {
  final String id;
  final String name;
  final String imageUrl;
  ProductCategory({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  static List<ProductCategory> values = [
    _category,
    _category.copyWith(id: '2', name: 'Armchairs', imageUrl: _imagesUrls[1]),
    _category.copyWith(id: '3', name: 'Tables', imageUrl: _imagesUrls[2]),
    _category.copyWith(id: '4', name: 'Beds', imageUrl: _imagesUrls[3]),
    _category.copyWith(id: '5', name: 'Accessories', imageUrl: _imagesUrls[4]),
    _category.copyWith(id: '6', name: 'Lights', imageUrl: _imagesUrls[5]),
  ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory ProductCategory.fromMap(Map<String, dynamic> map) {
    return ProductCategory(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCategory.fromJson(String source) =>
      ProductCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  ProductCategory copyWith({
    String? id,
    String? name,
    String? imageUrl,
  }) {
    return ProductCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

final _category = ProductCategory(
  id: '1',
  name: 'Sofas',
  imageUrl: _imagesUrls[0],
);

const _imagesUrls = [
  'images/Sofa.cat.png',
  'images/arm.png',
  'images/table.png',
  'images/bedd.jpeg',
  'images/accessoriess.jpeg',
  'images/light.jpeg'
];
