import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'blog_card.dart';
import '../../utils/constants.dart';
import '../../models/blog_model.dart';
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
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      print('Fetching latest blogs from: $blogApiUrl');

      final response = await http.get(
        Uri.parse(blogApiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> blogsJson = json.decode(response.body);

        final allBlogs = blogsJson.map((json) => Blog.fromJson(json)).toList();

        // Sort by date (newest first) and take latest 10
        allBlogs.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        setState(() {
          _latestBlogs = allBlogs.take(10).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching latest blogs: $e');
      setState(() {
        _error = 'Failed to load blogs. Please try again later.';
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

    if (_error != null || _latestBlogs.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          RichText(
            text: const TextSpan(
              text: 'Latest ',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              children: [
                TextSpan(
                  text: 'Blogs',
                  style: TextStyle(color: toyBlue),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Stay updated with our latest toy guides and insights',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > 1200
                  ? 3
                  : constraints.maxWidth > 900
                      ? 2
                      : 1;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _latestBlogs.length,
                itemBuilder: (context, index) {
                  return BlogCard(blog: _latestBlogs[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
