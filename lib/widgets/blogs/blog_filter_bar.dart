// lib/widgets/blogs/blog_filter_bar.dart
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class BlogFilterBar extends StatelessWidget {
  final String searchQuery;
  final Function(String) onSearchChanged;
  final String sortBy;
  final Function(String) onSortChanged;
  final int totalResults;

  const BlogFilterBar({
    super.key,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.sortBy,
    required this.onSortChanged,
    required this.totalResults,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Column(
          children: [
            if (isMobile) ...[
              // Mobile layout - stacked
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: TextField(
                  onChanged: onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search articles...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: DropdownButtonFormField<String>(
                  value: sortBy,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: 'Newest First', child: Text('Newest First')),
                    DropdownMenuItem(
                        value: 'Oldest First', child: Text('Oldest First')),
                    DropdownMenuItem(
                        value: 'Most Popular', child: Text('Most Popular')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      onSortChanged(value);
                    }
                  },
                ),
              ),
            ] else ...[
              // Desktop layout - side by side
              Row(
                children: [
                  // Search bar
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      ),
                      child: TextField(
                        onChanged: onSearchChanged,
                        decoration: InputDecoration(
                          hintText: 'Search articles, topics, or keywords...',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          prefixIcon:
                              Icon(Icons.search, color: Colors.grey[400]),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Sort dropdown
                  Container(
                    width: 200,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: sortBy,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'Newest First', child: Text('Newest First')),
                        DropdownMenuItem(
                            value: 'Oldest First', child: Text('Oldest First')),
                        DropdownMenuItem(
                            value: 'Most Popular', child: Text('Most Popular')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          onSortChanged(value);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 12),
            // Results count
            Row(
              children: [
                Text(
                  'Showing $totalResults ${totalResults == 1 ? 'result' : 'results'}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
