// lib/widgets/blogs/latest_blogs.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'blog_card.dart';
import '../../utils/constants.dart';
import '../../models/blog_model.dart';
import '../../utils/responsive.dart';
import '../../utils/blog_data.dart';

class LatestBlogs extends StatefulWidget {
  const LatestBlogs({super.key});

  @override
  State<LatestBlogs> createState() => _LatestBlogsState();
}

class _LatestBlogsState extends State<LatestBlogs> {
  List<Blog> _latestBlogs = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchLatestBlogs();
  }

  Future<void> _fetchLatestBlogs() async {
    try {
      final response = await http.get(Uri.parse(blogApiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> blogsJson = json.decode(response.body);
        final allBlogs = blogsJson.map((json) => Blog.fromJson(json)).toList();

        allBlogs.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        setState(() {
          _latestBlogs = allBlogs.take(10).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Server error');
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to load blogs';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _error != null || _latestBlogs.isEmpty) {
      return const SizedBox.shrink();
    }

    int crossAxisCount = Responsive.getCrossAxisCount(context);
    double spacing = Responsive.getCardSpacing(context);

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          const Text(
            "Latest Blogs",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _latestBlogs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              childAspectRatio: 0.75, // FIXED
            ),
            itemBuilder: (context, index) {
              return BlogCard(blog: _latestBlogs[index]);
            },
          ),
        ],
      ),
    );
  }
}
