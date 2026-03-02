// lib/widgets/categories/category_pill.dart
import 'package:flutter/material.dart';
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
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [toyBlue, Color(0xFF2563EB)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: toyBlue.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 12,
                      ),
                      SizedBox(width: 2),
                      Text(
                        'POPULAR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: _isHovered
                  ? const LinearGradient(
                      colors: [toyBlue, Color(0xFF2563EB)],
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
                      : Colors.grey.withOpacity(0.2),
                  spreadRadius: _isHovered ? 2 : 1,
                  blurRadius: _isHovered ? 8 : 4,
                  offset: Offset(0, _isHovered ? 4 : 2),
                ),
              ],
              border: Border.all(
                color: _isHovered
                    ? Colors.transparent
                    : Colors.grey.withOpacity(0.2),
              ),
            ),
            child: Text(
              widget.name,
              style: TextStyle(
                color: _isHovered ? Colors.white : const Color(0xFF334155),
                fontSize: 14,
                fontWeight:
                    widget.isPopular ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
