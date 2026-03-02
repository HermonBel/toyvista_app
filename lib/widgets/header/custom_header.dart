// lib/widgets/header/custom_header.dart
import 'package:flutter/material.dart';
import 'nav_link.dart';
import '../../utils/constants.dart';
import '../../screens/blogs_screen.dart';
import '../../screens/why_toy_vista_screen.dart';
import '../../screens/disclaimer_screen.dart';
import '../../screens/search_results_screen.dart'; // Add this import

class CustomHeader extends StatefulWidget {
  final bool showSearchBar;

  const CustomHeader({
    super.key,
    this.showSearchBar = true,
  });

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  bool _isMenuOpen = false;
  bool _isSearchVisible = false;
  final TextEditingController _searchController = TextEditingController();

  void _handleSearch(String query) {
    if (query.trim().isEmpty) return;

    // Navigate to search results screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsScreen(query: query),
      ),
    );

    // Clear search and close menu on mobile
    _searchController.clear();
    setState(() {
      _isMenuOpen = false;
      _isSearchVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 800;

    return Container(
      decoration: const BoxDecoration(
        gradient: headerGradient,
      ),
      child: Column(
        children: [
          // Header Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                // Logo
                _buildLogo(context),

                // Desktop Search Bar
                if (!isMobile && widget.showSearchBar) ...[
                  const SizedBox(width: 24),
                  Expanded(
                    child: _buildDesktopSearchBar(),
                  ),
                ],

                const Spacer(),

                // Mobile Icons
                if (isMobile) ...[
                  if (widget.showSearchBar)
                    IconButton(
                      icon: Icon(
                        _isSearchVisible ? Icons.close : Icons.search,
                        color: toyDark,
                        size: 28,
                      ),
                      onPressed: () {
                        setState(() {
                          _isSearchVisible = !_isSearchVisible;
                        });
                      },
                    ),
                  IconButton(
                    icon: Icon(
                      _isMenuOpen ? Icons.close : Icons.menu,
                      color: toyDark,
                      size: 28,
                    ),
                    onPressed: () {
                      setState(() {
                        _isMenuOpen = !_isMenuOpen;
                      });
                    },
                  ),
                ],

                // Desktop Navigation
                if (!isMobile)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      NavLink(
                        title: 'Home',
                        onTap: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                      ),
                      NavLink(
                        title: 'Blogs',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BlogsScreen()),
                          );
                        },
                      ),
                      NavLink(
                        title: 'Why Toy Vista?',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const WhyToyVistaScreen()),
                          );
                        },
                      ),
                      NavLink(
                        title: 'Disclaimer',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DisclaimerScreen()),
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),

          // Mobile Search Bar
          if (isMobile && _isSearchVisible) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: _buildMobileSearchBar(),
            ),
          ],

          // Mobile Dropdown Menu
          if (isMobile && _isMenuOpen) _buildMobileMenu(),
        ],
      ),
    );
  }

  Widget _buildMobileMenu() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.home, color: toyBlue),
            title: const Text('Home'),
            onTap: () {
              setState(() => _isMenuOpen = false);
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
          ListTile(
            leading: const Icon(Icons.article, color: toyBlue),
            title: const Text('Blogs'),
            onTap: () {
              setState(() => _isMenuOpen = false);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BlogsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.question_answer, color: toyBlue),
            title: const Text('Why Toy Vista?'),
            onTap: () {
              setState(() => _isMenuOpen = false);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WhyToyVistaScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: toyBlue),
            title: const Text('Disclaimer'),
            onTap: () {
              setState(() => _isMenuOpen = false);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DisclaimerScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.popUntil(context, (route) => route.isFirst);
      },
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'TOY',
                style: TextStyle(
                  color: toyBlue,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Vista',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: toyDark,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 4,
                    decoration: BoxDecoration(
                      color: toyBlue,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Container(
                    width: 8,
                    height: 4,
                    decoration: BoxDecoration(
                      color: toyYellow,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopSearchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onSubmitted: _handleSearch,
        decoration: InputDecoration(
          hintText: 'Search for toys, games, and more...',
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          suffixIcon: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: toyYellow,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.white, size: 20),
              onPressed: () => _handleSearch(_searchController.text),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileSearchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onSubmitted: _handleSearch,
        decoration: InputDecoration(
          hintText: 'Search for toys, games, and more...',
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          suffixIcon: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: toyYellow,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.white, size: 20),
              onPressed: () => _handleSearch(_searchController.text),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
    );
  }
}
