// lib/widgets/products/product_card.dart
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class ProductCard extends StatefulWidget {
  final String title;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: _isHovered
            ? (Matrix4.identity()..translate(0, -5))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? toyBlue.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.1),
              spreadRadius: _isHovered ? 3 : 1,
              blurRadius: _isHovered ? 15 : 10,
              offset: Offset(0, _isHovered ? 8 : 2),
            ),
          ],
          border: Border.all(
            color: _isHovered
                ? toyBlue.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: toyBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.toys, color: toyBlue, size: 40),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Title
            Expanded(
              flex: 2,
              child: Text(
                widget.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: _isHovered ? toyBlue : Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Price
            Text(
              widget.price,
              style: TextStyle(
                color: _isHovered ? toyBlue : toyBlue,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),

            // Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: _isHovered ? Colors.white : toyBlue,
                  backgroundColor: _isHovered ? toyBlue : Colors.transparent,
                  side: BorderSide(
                    color: _isHovered ? toyBlue : toyBlue,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('View Details'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
