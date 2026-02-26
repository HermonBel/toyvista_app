// lib/widgets/header/custom_header.dart
import 'package:flutter/material.dart';
import 'nav_link.dart';
import '../../utils/constants.dart';
import '../../screens/blogs_screen.dart';
import '../../screens/why_toy_vista_screen.dart';
import '../../screens/disclaimer_screen.dart';

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
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 800;

    return Container(
      decoration: const BoxDecoration(
        gradient: headerGradient,
      ),
      child: Column(
        children: [
          // Header Bar (always visible)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                // Logo (left side)
                _buildLogo(context),

                // Desktop Search Bar (in same row, only on desktop)
                if (!isMobile && widget.showSearchBar) ...[
                  const SizedBox(width: 24),
                  Expanded(
                    child: _buildDesktopSearchBar(),
                  ),
                ],

                const Spacer(),

                // Mobile Menu Icon (only visible on mobile)
                if (isMobile)
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

                // Desktop Navigation (visible on desktop)
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

          // Mobile Dropdown Menu (appears from top)
          if (isMobile && _isMenuOpen)
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  // Search Bar inside dropdown
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search, color: toyBlue),
                            onPressed: () {
                              // Handle search
                              print('Searching for: ${_searchController.text}');
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Divider
                  Divider(height: 1, color: Colors.grey[300]),

                  // Menu Items
                  _buildMenuItem(
                    icon: Icons.home,
                    title: 'Home',
                    onTap: () {
                      setState(() => _isMenuOpen = false);
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.article,
                    title: 'Blogs',
                    onTap: () {
                      setState(() => _isMenuOpen = false);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BlogsScreen()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.question_answer,
                    title: 'Why Toy Vista?',
                    onTap: () {
                      setState(() => _isMenuOpen = false);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WhyToyVistaScreen()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.info,
                    title: 'Disclaimer',
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
            ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: toyBlue, size: 24),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: toyDark,
              ),
            ),
          ],
        ),
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
              onPressed: () {
                // Handle search
                print('Searching for: ${_searchController.text}');
              },
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
    );
  }
}
