// lib/widgets/products/trending_products.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product_card.dart';
import '../../utils/constants.dart';
import '../../models/product_model.dart';
import '../../utils/product_data.dart';

class TrendingProducts extends StatefulWidget {
  const TrendingProducts({super.key});

  @override
  State<TrendingProducts> createState() => _TrendingProductsState();
}

class _TrendingProductsState extends State<TrendingProducts> {
  List<Product> _trendingProducts = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchTrendingProducts();
  }

  Future<void> _fetchTrendingProducts() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      print('Fetching products from: $productApiUrl');

      final response = await http.get(
        Uri.parse(productApiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 100));

      if (response.statusCode == 200) {
        final List<dynamic> productsJson = json.decode(response.body);

        final allProducts =
            productsJson.map((json) => Product.fromJson(json)).toList();

        // Filter trending products (is_trending == true) and take first 8
        final trending = allProducts.where((p) => p.isTrending).toList();

        // If not enough trending products, take any products
        final displayProducts = trending.isNotEmpty ? trending : allProducts;

        setState(() {
          _trendingProducts = displayProducts.take(8).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        _error = 'Failed to load products';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.all(32.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null || _trendingProducts.isEmpty) {
      return const SizedBox
          .shrink(); // Don't show section if error or no products
    }

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          RichText(
            text: const TextSpan(
              text: 'Trending ',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              children: [
                TextSpan(
                  text: 'Products',
                  style: TextStyle(color: toyBlue),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(width: 80, height: 4, color: toyBlue),
          const SizedBox(height: 32),

          // Responsive grid
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > 1200
                  ? 4
                  : constraints.maxWidth > 900
                      ? 3
                      : constraints.maxWidth > 600
                          ? 2
                          : 1;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _trendingProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: _trendingProducts[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
