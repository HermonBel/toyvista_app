// lib/models/blog_model.dart
class Blog {
  final String id;
  final String title;
  final String content;
  final DateTime
      createdAt; // Make sure this is EXACTLY 'createdAt' (lowercase c, uppercase A)
  final String imageUrl;
  final String slug;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt, // Must match exactly
    required this.imageUrl,
    required this.slug,
  });

  // Factory constructor to create Blog from your API JSON
  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? 'Untitled',
      content: json['content'] ?? '',
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      imageUrl: json['image_url'] ?? '',
      slug: json['slug'] ?? '',
    );
  }

  // Generate excerpt from content (first 150 characters, strip HTML)
  String get excerpt {
    // Simple HTML tag removal
    final plainText = content.replaceAll(RegExp(r'<[^>]*>'), ' ');
    return plainText.length > 150
        ? '${plainText.substring(0, 150)}...'
        : plainText;
  }

  // Format date for display
  String get formattedDate {
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
    return '${months[createdAt.month - 1]} ${createdAt.day}, ${createdAt.year}';
  }

  // Generate read time based on content length
  String get readTime {
    final wordCount = content.split(RegExp(r'\s+')).length;
    final minutes = (wordCount / 200).ceil();
    return '$minutes min read';
  }

  String get category => 'Article';
  int? get popularity => null;
}
