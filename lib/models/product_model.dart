class Product {
  final String title;
  final String price;
  final String imageUrl;
  final double rating;
  final bool inStock;

  Product({
    required this.title,
    required this.price,
    required this.imageUrl,
    this.rating = 4.5,
    this.inStock = true,
  });

  factory Product.fromMap(Map<String, String> map) {
    return Product(
      title: map['title']!,
      price: map['price']!,
      imageUrl: map['image']!,
    );
  }
}
