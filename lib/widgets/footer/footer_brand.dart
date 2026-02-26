// lib/widgets/footer/footer_brand.dart
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class FooterBrand extends StatefulWidget {
  const FooterBrand({super.key});

  @override
  State<FooterBrand> createState() => _FooterBrandState();
}

class _FooterBrandState extends State<FooterBrand>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(); // Repeats forever

    _rotationAnimation = Tween<double>(begin: -0.1, end: 0.3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Animated Logo Row
            Transform.rotate(
              angle: _rotationAnimation.value,
              child: Row(
                children: [
                  // Logo Circle with glow effect
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: toyBlue.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'TOY',
                        style: TextStyle(
                          color: toyBlue,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
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
            ),
            const SizedBox(height: 16),
            const Text(
              'Your one-stop shop for toys!',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        );
      },
    );
  }
}
