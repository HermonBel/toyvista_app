// lib/widgets/footer/footer_brand.dart
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class FooterBrand extends StatelessWidget {
  const FooterBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF10B981)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'TOY',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Vista',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Your one-stop shop for toys! We provide the best selection of educational, fun, and trending toys for children of all ages.',
          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13, height: 1.5),
        ),
      ],
    );
  }
}
