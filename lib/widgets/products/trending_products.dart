import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product_card.dart';
import '../../utils/constants.dart';
import '../../models/product_model.dart';
import '../../utils/responsive.dart';
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

  static List<Product>? _cachedProducts;
  static DateTime? _lastFetchTime;
  static const Duration _cacheDuration = Duration(minutes: 5);

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
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
    try {
      final response = await http.get(Uri.parse(productApiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> productsJson = json.decode(response.body);
        final allProducts =
            productsJson.map((json) => Product.fromJson(json)).toList();

        final trending = allProducts.where((p) => p.isTrending).toList();
        final displayProducts = trending.isNotEmpty ? trending : allProducts;

        _cachedProducts = displayProducts.take(8).toList();
        _lastFetchTime = DateTime.now();

        setState(() {
          _trendingProducts = _cachedProducts!;
          _isLoading = false;
        });
      } else {
        throw Exception('Server error');
      }
    } catch (e) {
      if (_cachedProducts != null) {
        setState(() {
          _trendingProducts = _cachedProducts!;
          _isLoading = false;
          _error = 'Using cached data.';
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

    int crossAxisCount = Responsive.getCrossAxisCount(context);
    double spacing = Responsive.getCardSpacing(context);

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          const Text(
            "Trending Products",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                _error!,
                style: const TextStyle(color: Colors.orange),
              ),
            ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _trendingProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,

              // 🔥 THIS FIXES OVERFLOW
              childAspectRatio: 0.6,
            ),
            itemBuilder: (context, index) {
              return ProductCard(
                product: _trendingProducts[index],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSkeleton() {
    int crossAxisCount = Responsive.getCrossAxisCount(context);
    double spacing = Responsive.getCardSpacing(context);

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 8,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,

          // 🔥 MUST MATCH REAL GRID
          childAspectRatio: 0.6,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
          );
        },
      ),
    );
  }
}
