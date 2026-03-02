// lib/models/category_model.dart
class Category {
  final String id;
  final String name;
  final DateTime createdAt;
  final String slug;
  final bool isPopular;

  Category({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.slug,
    this.isPopular = false,
  });

  // Factory constructor to create Category from your API JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? 'Unnamed Category',
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      slug: json['slug'] ?? '',
      isPopular: false, // Default to false
    );
  }

  // Add this named constructor for creating with popular flag
  factory Category.fromJsonWithPopular(Map<String, dynamic> json,
      {required bool popular}) {
    return Category(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? 'Unnamed Category',
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      slug: json['slug'] ?? '',
      isPopular: popular,
    );
  }
}
