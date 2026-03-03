// lib/utils/responsive.dart
import 'package:flutter/material.dart';

class Responsive {
  // Breakpoints
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;

  // Screen size checks
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobile;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobile &&
      MediaQuery.of(context).size.width < tablet;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tablet;

  // Grid configuration
  static int getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > desktop) return 4;
    if (width > tablet) return 3;
    if (width > mobile) return 2;
    return 2;
  }

  static double getCardSpacing(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobile) return 10;
    if (width < tablet) return 12;
    return 16;
  }

  // DYNAMIC CARD HEIGHTS
  static double getProductCardHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < mobile) return screenHeight * 0.4; // 40% of screen height
    if (screenWidth < tablet)
      return screenHeight * 0.38; // 38% of screen height
    if (screenWidth < desktop)
      return screenHeight * 0.35; // 35% of screen height
    return screenHeight * 0.32; // 32% of screen height
  }

  static double getBlogCardHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < mobile)
      return screenHeight * 0.38; // 38% of screen height
    if (screenWidth < tablet)
      return screenHeight * 0.35; // 35% of screen height
    if (screenWidth < desktop)
      return screenHeight * 0.32; // 32% of screen height
    return screenHeight * 0.3; // 30% of screen height
  }

  // DYNAMIC IMAGE HEIGHTS
  static double getProductImageHeight(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < mobile) return screenWidth * 0.35; // 35% of width
    if (screenWidth < tablet) return screenWidth * 0.3; // 30% of width
    return screenWidth * 0.25; // 25% of width
  }

  static double getBlogImageHeight(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < mobile) return screenWidth * 0.3; // 30% of width
    if (screenWidth < tablet) return screenWidth * 0.25; // 25% of width
    return screenWidth * 0.2; // 20% of width
  }

  // DYNAMIC FONT SIZES
  static double getTitleFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < mobile) return screenWidth * 0.035; // 3.5% of width
    if (screenWidth < tablet) return screenWidth * 0.03; // 3% of width
    return screenWidth * 0.025; // 2.5% of width
  }

  static double getBodyFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < mobile) return screenWidth * 0.03; // 3% of width
    if (screenWidth < tablet) return screenWidth * 0.025; // 2.5% of width
    return screenWidth * 0.02; // 2% of width
  }

  static double getSmallFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < mobile) return screenWidth * 0.025; // 2.5% of width
    if (screenWidth < tablet) return screenWidth * 0.02; // 2% of width
    return screenWidth * 0.015; // 1.5% of width
  }
}
