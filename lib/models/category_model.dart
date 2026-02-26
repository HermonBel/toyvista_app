class Category {
  final String name;
  final bool isPopular;
  final String? icon;

  Category({
    required this.name,
    this.isPopular = false,
    this.icon,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'],
      isPopular: map['popular'] ?? false,
    );
  }
}
