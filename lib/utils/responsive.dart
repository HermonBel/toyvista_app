// lib/utils/responsive.dart
import 'package:flutter/material.dart';

class Responsive {
  static double getAspectRatio(BuildContext context,
      {required String cardType}) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    // Calculate based on screen proportions
    // Formula: aspectRatio = (cardWidth / cardHeight)
    // We want cards to be proportional to screen size

    if (cardType == 'product') {
      // Products need more vertical space for images
      if (screenWidth < 400) {
        // Very small phones (iPhone SE)
        return 0.75;
      } else if (screenWidth < 600) {
        // Regular phones
        // Use screen ratio to determine card shape
        return (screenWidth / screenHeight) * 2.2;
      } else if (screenWidth < 900) {
        // Tablets
        return (screenWidth / screenHeight) * 1.8;
      } else {
        // Desktop
        return 0.7;
      }
    } else if (cardType == 'blog') {
      // Blogs need different proportions
      if (screenWidth < 400) {
        return 0.8;
      } else if (screenWidth < 600) {
        return (screenWidth / screenHeight) * 2.0;
      } else if (screenWidth < 900) {
        return (screenWidth / screenHeight) * 1.6;
      } else {
        return 0.75;
      }
    }

    // Default fallback
    return 0.8;
  }

  static double getCardSpacing(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return 10; // Mobile
    } else if (screenWidth < 900) {
      return 16; // Tablet
    } else {
      return 20; // Desktop
    }
  }

  static int getCrossAxisCount(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 1200) {
      return 4; // Desktop - 4 columns
    } else if (screenWidth > 900) {
      return 3; // Small desktop/tablet - 3 columns
    } else if (screenWidth > 600) {
      return 2; // Tablet - 2 columns
    } else {
      return 2; // Mobile - 2 columns
    }
  }
}
