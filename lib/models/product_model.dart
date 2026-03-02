// lib/models/product_model.dart
class Product {
  final String id;
  final String name;
  final String? description;
  final String? price;
  final String trackingLink;
  final String asin;
  final String imageUrl;
  final String subcategoryId;
  final DateTime createdAt;
  final bool isTrending;
  final String slug;

  Product({
    required this.id,
    required this.name,
    this.description,
    this.price,
    required this.trackingLink,
    required this.asin,
    required this.imageUrl,
    required this.subcategoryId,
    required this.createdAt,
    required this.isTrending,
    required this.slug,
  });

  // Factory constructor to create Product from your API JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Untitled Product',
      description: json['description']?.toString(),
      price: json['price']?.toString(),
      trackingLink: json['tracking_link']?.toString() ?? '',
      asin: json['asin']?.toString() ?? '',
      imageUrl: json['image_url']?.toString() ?? '',
      subcategoryId: json['subcategory_id']?.toString() ?? '',
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      isTrending: json['is_trending'] == '1',
      slug: json['slug']?.toString() ?? '',
    );
  }

  // Format price with currency symbol
  String get formattedPrice {
    if (price == null || price!.isEmpty) return 'Price unavailable';
    if (price!.startsWith('\$')) return price!;
    return '\$${price}';
  }

  // Format date for display
  String get formattedDate {
    final date = createdAt;
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
