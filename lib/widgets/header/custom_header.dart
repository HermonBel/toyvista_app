import 'package:flutter/material.dart';
import 'nav_link.dart';
import '../../utils/constants.dart';
import '../../screens/blogs_screen.dart';
import '../../screens/why_toy_vista_screen.dart';
import '../../screens/disclaimer_screen.dart';
import '../../screens/search_results_screen.dart';

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

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsScreen(query: query),
      ),
    );

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
        gradient: LinearGradient(
          colors: [Color(0xFFBAE6FD), Color(0xFFBBF7D0)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        children: [
          // Header Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                // Logo - Clickable to home
                _buildLogo(context),

                // Desktop Search Bar
                if (!isMobile && widget.showSearchBar) ...[
                  const SizedBox(width: 40),
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
                        color: const Color(0xFF1E293B),
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
                      color: const Color(0xFF1E293B),
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
            leading: const Icon(Icons.home, color: Color(0xFF2563EB)),
            title: const Text('Home'),
            onTap: () {
              setState(() => _isMenuOpen = false);
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
          ListTile(
            leading: const Icon(Icons.article, color: Color(0xFF2563EB)),
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
            leading:
                const Icon(Icons.question_answer, color: Color(0xFF2563EB)),
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
            leading: const Icon(Icons.info, color: Color(0xFF2563EB)),
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TOY text
            const Text(
              'TOY',
              style: TextStyle(
                color: Color(0xFF10B981), // Emerald green
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(width: 2),
            // Vista text
            const Text(
              'Vista',
              style: TextStyle(
                color: Color(0xFF2563EB), // Blue
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(width: 4),
            // Small dot/circle
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFFF59E0B), // Orange/amber
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopSearchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(40), // More curved
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Search icon on left
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Icon(
              Icons.search,
              color: Color(0xFF94A3B8),
              size: 20,
            ),
          ),

          // Text field
          Expanded(
            child: TextField(
              controller: _searchController,
              onSubmitted: _handleSearch,
              decoration: const InputDecoration(
                hintText: 'Search for toys, games, and more...',
                hintStyle: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                isDense: true,
              ),
            ),
          ),

          // Search button
          Container(
            margin: const EdgeInsets.all(4),
            child: ElevatedButton(
              onPressed: () => _handleSearch(_searchController.text),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFBBF24), // Yellow
                foregroundColor: const Color(0xFF1E293B),
                minimumSize: const Size(80, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Search',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileSearchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Icon(
              Icons.search,
              color: Color(0xFF94A3B8),
              size: 20,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _searchController,
              onSubmitted: _handleSearch,
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(4),
            child: IconButton(
              icon: const Icon(Icons.arrow_forward, color: Color(0xFF2563EB)),
              onPressed: () => _handleSearch(_searchController.text),
            ),
          ),
        ],
      ),
    );
  }
}
