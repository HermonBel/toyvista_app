// lib/widgets/blogs/blog_card.dart
import 'package:flutter/material.dart';
import '../../models/blog_model.dart';
import '../../utils/constants.dart';
import '../../screens/blog_detail_screen.dart';

class BlogCard extends StatefulWidget {
  final Blog blog;

  const BlogCard({
    super.key,
    required this.blog,
  });

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;
    final isTablet = screenWidth > 600 && screenWidth <= 900;
    final isMobile = screenWidth <= 600;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: _isHovered
            ? (Matrix4.identity()..translate(0, isDesktop ? -5 : -3))
            : Matrix4.identity(),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlogDetailScreen(blog: widget.blog),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(isDesktop ? 16 : 12),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? toyBlue.withOpacity(isDesktop ? 0.15 : 0.1)
                      : Colors.grey.withOpacity(0.05),
                  blurRadius: _isHovered ? (isDesktop ? 15 : 8) : 8,
                  offset: Offset(0, _isHovered ? (isDesktop ? 8 : 2) : 2),
                ),
              ],
              border: Border.all(
                color: _isHovered
                    ? toyBlue.withOpacity(isDesktop ? 0.3 : 0.2)
                    : Colors.grey.withOpacity(0.1),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image - MUCH BIGGER on mobile
                Stack(
                  children: [
                    Image.network(
                      widget.blog.imageUrl,
                      height: isDesktop
                          ? 200
                          : (isTablet
                              ? 180
                              : 150), // Increased mobile from 100 to 150
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: isDesktop ? 200 : (isTablet ? 180 : 150),
                          color: Colors.grey[200],
                          child: Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                              size: isMobile ? 40 : 30,
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      top: isDesktop ? 12 : 8,
                      left: isDesktop ? 12 : 8,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: isDesktop ? 10 : 8,
                            vertical: isDesktop ? 4 : 3),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0EA5E9), Color(0xFF10B981)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius:
                              BorderRadius.circular(isDesktop ? 12 : 8),
                        ),
                        child: Text(
                          widget.blog.category,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isDesktop ? 11 : (isMobile ? 10 : 9),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.all(isDesktop ? 16 : 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Date row
                      _buildDateRow(context),

                      SizedBox(height: isDesktop ? 12 : 8),

                      // Title - BIGGER on mobile
                      Text(
                        widget.blog.title,
                        style: TextStyle(
                          fontSize: isDesktop
                              ? 16
                              : (isMobile ? 15 : 14), // Increased mobile
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E293B),
                          height: 1.3,
                        ),
                        maxLines: isDesktop ? 3 : 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: isDesktop ? 8 : 6),

                      // Excerpt - BIGGER on mobile
                      Text(
                        widget.blog.excerpt,
                        style: TextStyle(
                          fontSize: isDesktop
                              ? 14
                              : (isMobile ? 13 : 12), // Increased mobile
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                        maxLines: isDesktop ? 3 : (isTablet ? 2 : 2),
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: isDesktop ? 16 : 12),

                      // Read More button - BIGGER on mobile
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: isDesktop ? 16 : (isMobile ? 14 : 12),
                            vertical: isDesktop ? 8 : (isMobile ? 8 : 6)),
                        decoration: BoxDecoration(
                          color: _isHovered ? toyBlue : Colors.transparent,
                          borderRadius:
                              BorderRadius.circular(isDesktop ? 20 : 16),
                          border: Border.all(
                            color: _isHovered ? Colors.transparent : toyBlue,
                            width: isDesktop ? 1 : 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isDesktop ? 'Read More' : 'Read More',
                              style: TextStyle(
                                color: _isHovered ? Colors.white : toyBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: isDesktop
                                    ? 14
                                    : (isMobile ? 14 : 12), // Increased mobile
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward,
                              size: isDesktop
                                  ? 16
                                  : (isMobile ? 16 : 12), // Increased mobile
                              color: _isHovered ? Colors.white : toyBlue,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateRow(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Row(
      children: [
        Icon(Icons.calendar_today,
            size: isMobile ? 12 : 10, color: Colors.grey[500]),
        const SizedBox(width: 4),
        Text(
          widget.blog.formattedDate,
          style: TextStyle(
            fontSize: isMobile ? 12 : 10,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Icon(Icons.access_time,
            size: isMobile ? 12 : 10, color: Colors.grey[500]),
        const SizedBox(width: 4),
        Text(
          widget.blog.readTime,
          style: TextStyle(
            fontSize: isMobile ? 12 : 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
