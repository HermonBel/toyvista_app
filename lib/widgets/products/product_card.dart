// lib/widgets/products/product_card.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/product_model.dart';
import '../../utils/constants.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isHovered = false;

  Future<void> _openProductLink() async {
    final Uri url = Uri.parse(widget.product.trackingLink);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Could not open link: ${widget.product.trackingLink}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error opening link: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open link'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image - MUCH BIGGER on mobile
            Expanded(
              flex: isMobile ? 5 : 4, // More space for image on mobile
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: toyBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.product.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(Icons.toys,
                            color: toyBlue, size: isMobile ? 60 : 40),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Product details
            Padding(
              padding: EdgeInsets.all(isMobile ? 12 : 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title - more lines on mobile
                  Text(
                    widget.product.name,
                    maxLines: isMobile ? 3 : 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: isMobile ? 14 : 13,
                      color: _isHovered ? toyBlue : Colors.black87,
                    ),
                  ),
                  SizedBox(height: isMobile ? 8 : 4),

                  // Price
                  Text(
                    widget.product.formattedPrice,
                    style: TextStyle(
                      color: _isHovered ? toyBlue : toyBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 20 : 18,
                    ),
                  ),
                  SizedBox(height: isMobile ? 12 : 8),

                  // Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _openProductLink,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: _isHovered ? Colors.white : toyBlue,
                        backgroundColor:
                            _isHovered ? toyBlue : Colors.transparent,
                        side: BorderSide(
                          color: _isHovered ? toyBlue : toyBlue,
                        ),
                        elevation: 0,
                        padding: EdgeInsets.symmetric(
                          vertical: isMobile ? 14 : 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'View Details',
                        style: TextStyle(
                          fontSize: isMobile ? 15 : 13,
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
    );
  }
}
