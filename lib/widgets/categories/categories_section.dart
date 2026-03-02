// lib/widgets/categories/categories_section.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'category_pill.dart';
import '../../utils/constants.dart';
import '../../models/category_model.dart';
import '../../utils/category_data.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  List<Category> _categories = [];
  bool _isLoading = true;
  String? _error;

  // List of category names to mark as popular
  final List<String> _popularCategoryNames = [
    'Educational Toys',
    'LEGO Toys',
    'Coding Robots',
    'Action Figures',
    'Board Games',
  ];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      print('Fetching categories from: $categoryApiUrl');

      final response = await http.get(
        Uri.parse(categoryApiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 150));

      if (response.statusCode == 200) {
        final List<dynamic> categoriesJson = json.decode(response.body);

        _categories = categoriesJson.map<Category>((json) {
          final name = json['name'] ?? '';
          final isPopular = _popularCategoryNames.contains(name);
          return Category.fromJsonWithPopular(json, popular: isPopular);
        }).toList();

        setState(() {
          _isLoading = false;
        });
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('Network error - check internet connection');
      setState(() {
        _error = 'No internet connection';
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching categories: $e');
      setState(() {
        _error = 'Failed to load categories';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingSkeleton();
    }

    if (_error != null || _categories.isEmpty) {
      return const SizedBox.shrink(); // Hide section if error or no categories
    }

    return Column(
      children: [
        // Dark background ONLY for the title
        Container(
          width: double.infinity,
          color: toyDark,
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
          child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'Choose Toys from the ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w300),
                children: [
                  TextSpan(
                    text: 'Categories',
                    style: TextStyle(
                        color: toyBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 36),
                  ),
                  TextSpan(
                    text: ' below',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Categories grid - white background
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: _categories
                .map((category) => CategoryPill(
                      name: category.name,
                      isPopular: category.isPopular,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingSkeleton() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: toyDark,
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
          child: Center(
            child: Container(
              width: 400,
              height: 40,
              color: Colors.grey[800],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: List.generate(
              12,
              (index) => Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
