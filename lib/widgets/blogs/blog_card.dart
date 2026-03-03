// lib/widgets/blogs/blog_card.dart
import 'package:flutter/material.dart';
import '../../models/blog_model.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';
import '../../screens/blog_detail_screen.dart';

class BlogCard extends StatefulWidget {
  final Blog blog;

  const BlogCard({super.key, required this.blog});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered && isDesktop
            ? (Matrix4.identity()..translate(0, -5))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? toyBlue.withOpacity(0.15)
                  : Colors.grey.withOpacity(0.1),
              blurRadius: _isHovered ? 15 : 8,
              offset: Offset(0, _isHovered ? 8 : 2),
            ),
          ],
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlogDetailScreen(blog: widget.blog),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGE WITH PROPER RATIO
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  widget.blog.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.blog.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Responsive.getBodyFontSize(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.blog.excerpt,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Responsive.getSmallFontSize(context),
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlogDetailScreen(blog: widget.blog),
                          ),
                        );
                      },
                      child: const Text("Read More"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
