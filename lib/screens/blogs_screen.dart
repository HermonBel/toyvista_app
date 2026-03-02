import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/header/custom_header.dart';
import '../widgets/footer/custom_footer.dart';
import '../widgets/blogs/blog_card.dart';
import '../widgets/blogs/blog_filter_bar.dart';
import '../widgets/blogs/blog_pagination.dart';
import '../models/blog_model.dart';
import '../utils/blog_data.dart';
import '../utils/constants.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({super.key});

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  List<Blog> _allBlogs = [];
  List<Blog> _displayedBlogs = [];
  bool _isLoading = true;
  String? _error;

  String _searchQuery = '';
  String _sortBy = 'Newest First';
  int _currentPage = 1;
  final int _itemsPerPage = 6;

  @override
  void initState() {
    super.initState();
    _fetchBlogs();
  }

  Future<void> _fetchBlogs() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      print('Fetching blogs from: $blogApiUrl');

      final response = await http.get(
        Uri.parse(blogApiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> blogsJson = json.decode(response.body);

        _allBlogs = blogsJson.map((json) => Blog.fromJson(json)).toList();

        // Sort by date (newest first) by default
        _allBlogs.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        setState(() {
          _displayedBlogs = _allBlogs;
          _isLoading = false;
        });
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching blogs: $e');
      setState(() {
        _error =
            'Failed to load blogs. Please check your connection and try again.';
        _isLoading = false;
      });
    }
  }

  void _filterAndSortBlogs(String query, String sortBy) {
    setState(() {
      _searchQuery = query;
      _sortBy = sortBy;
      _currentPage = 1;

      // First filter
      List<Blog> filtered = _allBlogs;
      if (query.isNotEmpty) {
        filtered = _allBlogs.where((blog) {
          final searchLower = query.toLowerCase();
          return blog.title.toLowerCase().contains(searchLower) ||
              blog.excerpt.toLowerCase().contains(searchLower);
        }).toList();
      }

      // Then sort
      if (sortBy == 'Newest First') {
        filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      } else if (sortBy == 'Oldest First') {
        filtered.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      }

      _displayedBlogs = filtered;
    });
  }

  int get _totalPages => (_displayedBlogs.length / _itemsPerPage).ceil();

  List<Blog> get _paginatedBlogs {
    if (_displayedBlogs.isEmpty) return [];
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    if (startIndex >= _displayedBlogs.length) return [];
    return _displayedBlogs.sublist(
      startIndex,
      endIndex > _displayedBlogs.length ? _displayedBlogs.length : endIndex,
    );
  }

  void _handlePageChange(int page) {
    setState(() {
      _currentPage = page.clamp(1, _totalPages);
    });
  }

  void _handlePageInput(String value) {
    final page = int.tryParse(value);
    if (page != null && page >= 1 && page <= _totalPages) {
      _handlePageChange(page);
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
                  const Text(
                    'Blogs & Articles',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Filter Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: BlogFilterBar(
                      searchQuery: _searchQuery,
                      onSearchChanged: (query) =>
                          _filterAndSortBlogs(query, _sortBy),
                      sortBy: _sortBy,
                      onSortChanged: (sort) =>
                          _filterAndSortBlogs(_searchQuery, sort),
                      totalResults: _displayedBlogs.length,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Content
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (_error != null)
                    Center(
                      child: Column(
                        children: [
                          Text(_error!),
                          ElevatedButton(
                              onPressed: _fetchBlogs,
                              child: const Text('Retry')),
                        ],
                      ),
                    )
                  else if (_paginatedBlogs.isEmpty)
                    const Center(child: Text('No blogs found'))
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 1200
                                  ? 3
                                  : MediaQuery.of(context).size.width > 800
                                      ? 2
                                      : 1,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                        ),
                        itemCount: _paginatedBlogs.length,
                        itemBuilder: (context, index) {
                          return BlogCard(blog: _paginatedBlogs[index]);
                        },
                      ),
                    ),

                  const SizedBox(height: 40),

                  // Pagination
                  if (!_isLoading && _error == null && _totalPages > 1)
                    BlogPagination(
                      currentPage: _currentPage,
                      totalPages: _totalPages,
                      onPageChanged: _handlePageChange,
                      onPageInput: _handlePageInput,
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
