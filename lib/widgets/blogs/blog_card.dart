import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/blog_model.dart';
import '../../utils/constants.dart';

// lib/widgets/blogs/blog_card.dart
import 'package:flutter/material.dart';
import '../../models/blog_model.dart';
import '../../utils/constants.dart';

class BlogCard extends StatefulWidget {
  final Blog blog; // Make sure this matches

  const BlogCard({
    super.key,
    required this.blog, // Parameter name must be 'blog'
  });

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool _isHovered = false;
  bool _isButtonHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: _isHovered
            ? (Matrix4.identity()..translate(0, -8))
            : Matrix4.identity(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? toyBlue.withOpacity(0.15)
                    : Colors.black.withOpacity(0.05),
                blurRadius: _isHovered ? 20 : 10,
                offset: Offset(0, _isHovered ? 8 : 2),
              ),
            ],
            border: Border.all(
              color: _isHovered
                  ? toyBlue.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.1),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with category badge
              Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: 180,
                    width: double.infinity,
                    child: Image.network(
                      widget.blog.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(Icons.image_not_supported,
                                color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0EA5E9), Color(0xFF10B981)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        widget.blog.category.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date and read time
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.calendar_today,
                            size: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          widget.blog.formattedDate,
                          style: TextStyle(
                            color: _isHovered ? toyBlue : Colors.grey[600],
                            fontSize: 12,
                            fontWeight: _isHovered
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.access_time,
                          size: 12,
                          color: _isHovered ? toyBlue : Colors.grey[400],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.blog.readTime,
                          style: TextStyle(
                            color: _isHovered ? toyBlue : Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Title
                    Text(
                      widget.blog.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _isHovered ? toyBlue : Colors.grey[900],
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 12),

                    // Excerpt
                    Text(
                      widget.blog.excerpt,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 20),

                    // Read More button
                    MouseRegion(
                      onEnter: (_) => setState(() => _isButtonHovered = true),
                      onExit: (_) => setState(() => _isButtonHovered = false),
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to blog detail
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: _isButtonHovered
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFF0EA5E9),
                                      Color(0xFF10B981)
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  )
                                : null,
                            color: _isButtonHovered ? null : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: _isButtonHovered
                                  ? Colors.transparent
                                  : toyBlue,
                            ),
                            boxShadow: _isButtonHovered
                                ? [
                                    BoxShadow(
                                      color: toyBlue.withOpacity(0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    )
                                  ]
                                : null,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Read More',
                                style: TextStyle(
                                  color:
                                      _isButtonHovered ? Colors.white : toyBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 8),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                transform: _isButtonHovered
                                    ? (Matrix4.identity()..translate(3.0))
                                    : Matrix4.identity(),
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 16,
                                  color:
                                      _isButtonHovered ? Colors.white : toyBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
