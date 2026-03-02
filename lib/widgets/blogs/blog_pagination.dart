// lib/widgets/blogs/blog_pagination.dart
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class BlogPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;
  final Function(String) onPageInput;

  const BlogPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    required this.onPageInput,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        if (isMobile) {
          return _buildMobilePagination();
        } else {
          return _buildDesktopPagination();
        }
      },
    );
  }

  Widget _buildMobilePagination() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Previous button
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: currentPage > 1
                    ? () => onPageChanged(currentPage - 1)
                    : null,
                color: currentPage > 1 ? toyBlue : Colors.grey,
              ),
            ),
            const SizedBox(width: 16),
            // Page indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0EA5E9), Color(0xFF10B981)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$currentPage / $totalPages',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Next button
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: currentPage < totalPages
                    ? () => onPageChanged(currentPage + 1)
                    : null,
                color: currentPage < totalPages ? toyBlue : Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Page input
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Go to page: '),
              SizedBox(
                width: 50,
                child: TextField(
                  onSubmitted: onPageInput,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '#',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Previous button
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed:
                currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
            color: currentPage > 1 ? toyBlue : Colors.grey,
          ),
        ),
        const SizedBox(width: 16),

        // Page numbers
        ..._buildPageNumbers(),

        const SizedBox(width: 16),

        // Next button
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0EA5E9), Color(0xFF10B981)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextButton.icon(
            onPressed: currentPage < totalPages
                ? () => onPageChanged(currentPage + 1)
                : null,
            icon: const Text(
              'Next',
              style: TextStyle(color: Colors.white),
            ),
            label: const Icon(
              Icons.chevron_right,
              color: Colors.white,
            ),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Page input
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Text('Page: '),
              SizedBox(
                width: 50,
                child: TextField(
                  onSubmitted: onPageInput,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '#',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPageNumbers() {
    List<Widget> pages = [];

    for (int i = 1; i <= totalPages; i++) {
      // Show first, last, and current +/- 1
      if (i == 1 ||
          i == totalPages ||
          (i >= currentPage - 1 && i <= currentPage + 1)) {
        pages.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () => onPageChanged(i),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: i == currentPage
                      ? const LinearGradient(
                          colors: [Color(0xFF0EA5E9), Color(0xFF10B981)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: i == currentPage ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: i == currentPage
                      ? null
                      : Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: Center(
                  child: Text(
                    i.toString(),
                    style: TextStyle(
                      color: i == currentPage ? Colors.white : Colors.grey[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      } else if (i == currentPage - 2 || i == currentPage + 2) {
        pages.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '...',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 18,
              ),
            ),
          ),
        );
      }
    }

    return pages;
  }
}
