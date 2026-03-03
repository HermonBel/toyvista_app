import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product_card.dart';
import '../../utils/constants.dart';
import '../../models/product_model.dart';
import '../../utils/product_data.dart';
import '../../utils/responsive.dart';

class TrendingProducts extends StatefulWidget {
  const TrendingProducts({super.key});

  @override
  State<TrendingProducts> createState() => _TrendingProductsState();
}

class _TrendingProductsState extends State<TrendingProducts> {
  List<Product> _trendingProducts = [];
  bool _isLoading = true;
  String? _error;

  // Static cache to persist across widget rebuilds
  static List<Product>? _cachedProducts;
  static DateTime? _lastFetchTime;
  static const Duration _cacheDuration =
      Duration(minutes: 5); // Cache for 5 minutes

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    // Check if cache is still valid
    if (_cachedProducts != null &&
        _lastFetchTime != null &&
        DateTime.now().difference(_lastFetchTime!) < _cacheDuration) {
      setState(() {
        _trendingProducts = _cachedProducts!;
        _isLoading = false;
      });
      return;
    }

    await _fetchTrendingProducts();
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

        // Update cache
        _cachedProducts = displayProducts.take(8).toList();
        _lastFetchTime = DateTime.now();

        setState(() {
          _trendingProducts = _cachedProducts!;
          _isLoading = false;
        });
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');

      // If we have cached data, show it even if it's old
      if (_cachedProducts != null) {
        setState(() {
          _trendingProducts = _cachedProducts!;
          _isLoading = false;
          _error = 'Using cached data. Please check connection.';
        });
      } else {
        setState(() {
          _error = 'Failed to load products';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingSkeleton();
    }

    if (_error != null && _trendingProducts.isEmpty) {
      return const SizedBox.shrink();
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

          // Show error message if using cached data with connection issue
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange[200]!),
                ),
                child: Text(
                  _error!,
                  style: TextStyle(color: Colors.orange[800], fontSize: 12),
                ),
              ),
            ),

          // Responsive grid
          LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = constraints.maxWidth;

              int crossAxisCount;
              double aspectRatio;
              double spacing;

              if (screenWidth > 1200) {
                // Desktop: 4 columns
                crossAxisCount = 4;
                aspectRatio = 0.7; // Taller
                spacing = 16;
              } else if (screenWidth > 900) {
                // Small desktop/tablet: 3 columns
                crossAxisCount = 3;
                aspectRatio = 0.75; // Taller
                spacing = 16;
              } else if (screenWidth > 600) {
                // Tablet: 2 columns
                crossAxisCount = 2;
                aspectRatio = 0.8; // Taller
                spacing = 16;
              } else {
                // Mobile: 2 columns - MUCH TALLER cards
                crossAxisCount = 2;
                aspectRatio = 0.9; // Changed from 0.95 to 0.9 (even taller)
                spacing = 12;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: aspectRatio,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
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

  Widget _buildLoadingSkeleton() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          // Title skeleton
          Container(
            height: 40,
            width: 250,
            color: Colors.grey[200],
          ),
          const SizedBox(height: 8),
          Container(
            width: 80,
            height: 4,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 32),

          // Grid skeleton
          LayoutBuilder(
            builder: (context, constraints) {
              // Use dynamic values from Responsive class
              int crossAxisCount = Responsive.getCrossAxisCount(context);
              double aspectRatio =
                  Responsive.getAspectRatio(context, cardType: 'product');
              double spacing = Responsive.getCardSpacing(context);

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: aspectRatio,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
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

// Skeleton loader for product cards
class ProductCardSkeleton extends StatelessWidget {
  const ProductCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image skeleton
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(
                  Icons.image,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Title skeleton
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 100,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Price skeleton
          Container(
            width: 80,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),

          // Button skeleton
          Container(
            width: double.infinity,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
