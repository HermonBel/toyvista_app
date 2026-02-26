class Blog {
  final String title;
  final String date;
  final String imageUrl;
  final String? author;
  final int readTime;

  Blog({
    required this.title,
    required this.date,
    required this.imageUrl,
    this.author = 'ToyVista Staff',
    this.readTime = 5,
  });

  factory Blog.fromMap(Map<String, String> map) {
    return Blog(
      title: map['title']!,
      date: map['date']!,
      imageUrl: map['image']!,
    );
  }
}
