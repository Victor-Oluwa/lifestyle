import 'package:lifestyle/Common/strings/strings.dart';

class LifestyleDocument {
  final String id;
  final String name;
  final String imageUrl;
  final String documentUrl;
  LifestyleDocument({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.documentUrl,
  });

  static List<LifestyleDocument> values = [
    _document,
    _document.copyWith(
        id: '2',
        name: 'Brochure',
        imageUrl: _imageUrls[1],
        documentUrl: _documentUrl[1]),
  ];

  LifestyleDocument copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? documentUrl,
  }) {
    return LifestyleDocument(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      documentUrl: documentUrl ?? this.documentUrl,
    );
  }
}

final _document = LifestyleDocument(
  id: "1",
  documentUrl: _documentUrl[0],
  imageUrl: _imageUrls[0],
  name: 'Profile Document',
);

const _imageUrls = [
  'images/brochure.jpg',
  'images/bProfile.jpg',
];

const _documentUrl = [
  LifestyleStrings.brochureUrl,
  LifestyleStrings.profileDocUrl,
];
