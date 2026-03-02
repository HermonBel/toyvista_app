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
    // Get screen width to determine layout
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
                // Image with responsive height
                Stack(
                  children: [
                    Image.network(
                      widget.blog.imageUrl,
                      height: isDesktop ? 180 : (isTablet ? 140 : 100),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: isDesktop ? 180 : (isTablet ? 140 : 100),
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      top: isDesktop ? 12 : 6,
                      left: isDesktop ? 12 : 6,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: isDesktop ? 10 : 6,
                            vertical: isDesktop ? 4 : 2),
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
                            fontSize: isDesktop ? 11 : 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.all(isDesktop ? 16 : 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Date row - responsive
                      isDesktop
                          ? _buildDesktopDateRow()
                          : _buildCompactDateRow(),

                      SizedBox(height: isDesktop ? 12 : 6),

                      // Title - responsive
                      Text(
                        widget.blog.title,
                        style: TextStyle(
                          fontSize: isDesktop ? 16 : (isTablet ? 14 : 12),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E293B),
                          height: 1.3,
                        ),
                        maxLines: isDesktop ? 3 : 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: isDesktop ? 8 : 4),

                      // Excerpt - responsive (more lines on desktop)
                      Text(
                        widget.blog.excerpt,
                        style: TextStyle(
                          fontSize: isDesktop ? 14 : (isTablet ? 12 : 10),
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                        maxLines: isDesktop ? 3 : (isTablet ? 2 : 1),
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: isDesktop ? 16 : 8),

                      // Read More button - responsive
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: isDesktop ? 16 : 8,
                            vertical: isDesktop ? 8 : 4),
                        decoration: BoxDecoration(
                          color: _isHovered ? toyBlue : Colors.transparent,
                          borderRadius:
                              BorderRadius.circular(isDesktop ? 20 : 12),
                          border: Border.all(
                            color: _isHovered ? Colors.transparent : toyBlue,
                            width: isDesktop ? 1 : 0.5,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isDesktop ? 'Read More' : 'Read',
                              style: TextStyle(
                                color: _isHovered ? Colors.white : toyBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: isDesktop ? 14 : 9,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward,
                              size: isDesktop ? 16 : 8,
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

  // Desktop date row (full format)
  Widget _buildDesktopDateRow() {
    return Row(
      children: [
        Icon(Icons.calendar_today, size: 14, color: Colors.grey[500]),
        const SizedBox(width: 6),
        Text(
          widget.blog.formattedDate,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
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
        Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
        const SizedBox(width: 6),
        Text(
          widget.blog.readTime,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  // Mobile/Compact date row (short format)
  Widget _buildCompactDateRow() {
    return Row(
      children: [
        Icon(Icons.calendar_today, size: 8, color: Colors.grey[500]),
        const SizedBox(width: 2),
        Expanded(
          child: Text(
            _getShortDate(),
            style: TextStyle(
              fontSize: 8,
              color: Colors.grey[600],
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        const SizedBox(width: 4),
        Container(
          width: 2,
          height: 2,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Icon(Icons.access_time, size: 8, color: Colors.grey[500]),
        const SizedBox(width: 2),
        Flexible(
          child: Text(
            _getShortReadTime(),
            style: TextStyle(
              fontSize: 8,
              color: Colors.grey[600],
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  String _getShortDate() {
    try {
      final parts = widget.blog.formattedDate.split(' ');
      if (parts.length >= 3) {
        final month = _getMonthNumber(parts[0]);
        final day = parts[1].replaceAll(',', '');
        return '$month/$day';
      }
    } catch (e) {
      // Fallback
    }
    return widget.blog.formattedDate;
  }

  int _getMonthNumber(String month) {
    const months = {
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12,
    };
    return months[month] ?? 1;
  }

  String _getShortReadTime() {
    final parts = widget.blog.readTime.split(' ');
    if (parts.isNotEmpty) {
      return '${parts[0]}m';
    }
    return widget.blog.readTime;
  }
}
