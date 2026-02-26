// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../widgets/header/custom_header.dart';
import '../widgets/products/trending_products.dart';
import '../widgets/categories/categories_section.dart';
import '../widgets/blogs/latest_blogs.dart';
import '../widgets/footer/custom_footer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomHeader(showSearchBar: true), // Search bar visible
            TrendingProducts(),
            CategoriesSection(),
            LatestBlogs(),
            CustomFooter(),
          ],
        ),
      ),
    );
  }
}
