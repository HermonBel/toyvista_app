// lib/widgets/categories/category_pill.dart
import 'package:flutter/material.dart';
import 'popular_badge.dart';
import '../../utils/constants.dart';

class CategoryPill extends StatefulWidget {
  final String name;
  final bool isPopular;

  const CategoryPill({
    super.key,
    required this.name,
    this.isPopular = false,
  });

  @override
  State<CategoryPill> createState() => _CategoryPillState();
}

class _CategoryPillState extends State<CategoryPill> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (widget.isPopular)
            Positioned(
              top: -8,
              left: -8,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: _isHovered
                    ? (Matrix4.identity()..scale(1.1))
                    : Matrix4.identity(),
                child: const PopularBadge(),
              ),
            ),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              gradient: _isHovered
                  ? const LinearGradient(
                      colors: [toyBlue, Color(0xFF3B82F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: _isHovered ? null : Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? toyBlue.withOpacity(0.3)
                      : Colors.black.withOpacity(0.1),
                  spreadRadius: _isHovered ? 2 : 1,
                  blurRadius: _isHovered ? 8 : 4,
                  offset: Offset(0, _isHovered ? 4 : 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Handle category tap
                  print('Selected: ${widget.name}');
                },
                borderRadius: BorderRadius.circular(25),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Center(
                    child: Text(
                      widget.name,
                      style: TextStyle(
                        color: _isHovered ? Colors.white : toySlate,
                        fontSize: 13,
                        fontWeight: widget.isPopular
                            ? FontWeight.bold
                            : FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
