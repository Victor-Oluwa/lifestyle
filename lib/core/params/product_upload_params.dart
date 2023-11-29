import 'dart:io';

class ProductUploadParams {
  final String id;
  final String name;
  final String description;
  final String category;
  final String status;
  final int inStock;
  final double price;
  final List<File> images;
  final List<File> models;
  ProductUploadParams({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.status,
    required this.inStock,
    required this.price,
    required this.images,
    required this.models,
  });
}
