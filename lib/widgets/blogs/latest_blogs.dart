// lib/widgets/blogs/latest_blogs.dart
import 'package:flutter/material.dart';
import 'blog_card.dart';
import '../../utils/constants.dart';

class LatestBlogs extends StatelessWidget {
  const LatestBlogs({super.key});

  // Expanded blog list with 6 items
  final List<Map<String, String>> blogs = const [
    {
      'title':
          'Bloks - Which Building Toy Reigns Supreme? LEGO vs Mega Bloks vs K\'NEX',
      'date': 'Apr 15, 2025',
      'image': 'https://picsum.photos/seed/blog1/600/400',
      'author': 'Sarah Johnson',
    },
    {
      'title':
          'Growing Minds: The Power of Educational Toys for Cognitive Development',
      'date': 'Apr 14, 2025',
      'image': 'https://picsum.photos/seed/blog2/600/400',
      'author': 'Dr. Michael Chen',
    },
    {
      'title':
          'Child\'s Age: How to Pick the Perfect Toy for Every Developmental Stage',
      'date': 'Apr 13, 2025',
      'image': 'https://picsum.photos/seed/blog3/600/400',
      'author': 'Emma Williams',
    },
    {
      'title':
          'STEM Toys vs Traditional Toys: What\'s Best for Your Child\'s Future?',
      'date': 'Apr 12, 2025',
      'image': 'https://picsum.photos/seed/blog4/600/400',
      'author': 'Prof. Robert Taylor',
    },
    {
      'title': 'The Ultimate Guide to Outdoor Toys for Active Kids This Summer',
      'date': 'Apr 11, 2025',
      'image': 'https://picsum.photos/seed/blog5/600/400',
      'author': 'Jessica Martinez',
    },
    {
      'title': 'Top 10 Board Games That Make Learning Math and Reading Fun',
      'date': 'Apr 10, 2025',
      'image': 'https://picsum.photos/seed/blog6/600/400',
      'author': 'David Anderson',
    },
  ];

  @override
  Widget build(BuildContext context) {
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

          // Responsive grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 1200
                  ? 3
                  : MediaQuery.of(context).size.width > 900
                      ? 2
                      : 1,
              childAspectRatio: 0.9,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              return BlogCard(
                title: blogs[index]['title']!,
                date: blogs[index]['date']!,
                imageUrl: blogs[index]['image']!,
              );
            },
          ),
        ],
      ),
    );
  }
}
