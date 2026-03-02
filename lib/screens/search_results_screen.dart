// lib/screens/search_results_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/header/custom_header.dart';
import '../widgets/footer/custom_footer.dart';
import '../widgets/products/product_card.dart';
import '../models/product_model.dart';
import '../utils/product_data.dart';
import '../utils/constants.dart';

class SearchResultsScreen extends StatefulWidget {
  final String query;

  const SearchResultsScreen({
    super.key,
    required this.query,
  });

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  List<Product> _searchResults = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _performSearch();
  }

  Future<void> _performSearch() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      print('Searching for: ${widget.query}');

      final response = await http.get(
        Uri.parse(productApiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> productsJson = json.decode(response.body);

        final allProducts =
            productsJson.map((json) => Product.fromJson(json)).toList();

        // Filter products by search query
        final results = allProducts.where((product) {
          final query = widget.query.toLowerCase();
          return product.name.toLowerCase().contains(query) ||
              (product.description?.toLowerCase().contains(query) ?? false);
        }).toList();

        setState(() {
          _searchResults = results;
          _isLoading = false;
        });
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching products: $e');
      setState(() {
        _error = 'Failed to search products. Please try again.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomHeader(showSearchBar: false),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // Search header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Search Results',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Showing results for "${widget.query}"',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${_searchResults.length} products',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: toyBlue,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Results grid
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (_error != null)
                    Center(
                      child: Column(
                        children: [
                          Icon(Icons.error_outline,
                              size: 48, color: Colors.red[300]),
                          const SizedBox(height: 16),
                          Text(_error!),
                        ],
                      ),
                    )
                  else if (_searchResults.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'No products found matching "${widget.query}"',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: LayoutBuilder(
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
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: _searchResults.length,
                            itemBuilder: (context, index) {
                              return ProductCard(
                                  product: _searchResults[index]);
                            },
                          );
                        },
                      ),
                    ),

                  const SizedBox(height: 40),
                  const CustomFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
