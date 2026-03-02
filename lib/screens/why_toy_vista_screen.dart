import 'package:flutter/material.dart';
import '../widgets/header/custom_header.dart';
import '../widgets/footer/custom_footer.dart';
import '../utils/constants.dart';

class WhyToyVistaScreen extends StatelessWidget {
  const WhyToyVistaScreen({super.key});

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

                  // Centered container with max width for better readability
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 900, // Limits width on large screens
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40), // Increased side margins
                      padding: const EdgeInsets.all(
                          40), // Increased internal padding
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.08),
                            blurRadius: 20,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          const Center(
                            child: Text(
                              'Why ToyVista?',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Decorative underline - centered
                          Center(
                            child: Container(
                              width: 80,
                              height: 4,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF2563EB),
                                    Color(0xFF10B981)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Welcome paragraph
                          _buildWelcomeParagraph(),

                          const SizedBox(height: 24),

                          // Mission paragraph
                          _buildMissionParagraph(),

                          const SizedBox(height: 24),

                          // Navigation paragraph
                          _buildNavigationParagraph(),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Features Section - with same constraints
                  Container(
                    width: double.infinity,
                    color: Colors.grey[50],
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 900,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 48),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Here's why ToyVista is the best toy store online:",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Features list with enhanced cards
                            _buildFeatureCard(
                              icon: Icons.track_changes,
                              iconColor: const Color(0xFFEC4899),
                              iconBgColor: const Color(0xFFFDF2F8),
                              title: 'Precision Categories',
                              description:
                                  'No more endless scrolling – go directly to the toys that match your interest or age group.',
                            ),

                            const SizedBox(height: 20),

                            _buildFeatureCard(
                              icon: Icons.rocket_launch,
                              iconColor: const Color(0xFFF59E0B),
                              iconBgColor: const Color(0xFFFFFBEB),
                              title: 'Handpicked Selections',
                              description:
                                  'We bring you trending, high-rated, and unique toys from top platforms, all in one place.',
                            ),

                            const SizedBox(height: 20),

                            _buildFeatureCard(
                              icon: Icons.psychology,
                              iconColor: const Color(0xFF10B981),
                              iconBgColor: const Color(0xFFE6F7F0),
                              title: 'Focus on Learning',
                              description:
                                  'Discover a wide range of educational and developmental toys that spark creativity and learning.',
                            ),

                            const SizedBox(height: 20),

                            _buildFeatureCard(
                              icon: Icons.settings,
                              iconColor: const Color(0xFF6366F1),
                              iconBgColor: const Color(0xFFEEF2FF),
                              title: 'Tech Meets Fun',
                              description:
                                  'From hoverboards to RC drones, ToyVista connects you with cutting-edge toys kids love.',
                            ),

                            const SizedBox(height: 20),

                            _buildFeatureCard(
                              icon: Icons.lightbulb,
                              iconColor: const Color(0xFFF59E0B),
                              iconBgColor: const Color(0xFFFFFBEB),
                              title: 'Smart Shopping Experience',
                              description:
                                  'Fast-loading pages, clean design, and zero clutter for a user-friendly journey.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Goal Box - with same constraints
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 900,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFEFF6FF), Color(0xFFF0F9FF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: const Color(0xFF2563EB).withOpacity(0.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2563EB).withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 0,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF2563EB).withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.emoji_objects,
                                  color: Color(0xFF2563EB),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Expanded(
                                child: Text(
                                  'Our Goal',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'At ToyVista, our goal is simple – make toy discovery easy and exciting. Whether you\'re a parent, gift-giver, or toy enthusiast, you\'ll find that ToyVista is not just a toy store. It\'s the smarter way to shop for toys online.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 18,
                              height: 1.6,
                              color: Color(0xFF334155),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 64),

                  // FAQ Section - with same constraints
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 900,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 32),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Text(
                              'Frequently Asked Questions',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // FAQ Items with hover effects
                          _buildFAQCard(
                            question:
                                'What makes ToyVista different from other toy stores?',
                            answer:
                                'ToyVista focuses on precise categorization and smart filtering, allowing you to find exactly what you need without endless scrolling. We curate only the best toys from various platforms, saving you time and effort.',
                          ),

                          _buildFAQCard(
                            question: 'Do you sell toys directly?',
                            answer:
                                'ToyVista is a discovery platform that connects you with the best toys from various retailers. We provide detailed information, reviews, and direct links to purchase from trusted sellers.',
                          ),

                          _buildFAQCard(
                            question:
                                'How do you ensure toy safety and quality?',
                            answer:
                                'We feature toys from reputable manufacturers and retailers who adhere to strict safety standards. All featured products meet or exceed safety regulations for their respective age groups.',
                          ),

                          _buildFAQCard(
                            question:
                                'Can I find educational toys on ToyVista?',
                            answer:
                                'Absolutely! We have a dedicated section for educational toys, STEM kits, and learning resources. You can filter by age, subject, and learning objectives to find the perfect educational toy.',
                          ),

                          _buildFAQCard(
                            question: 'Is there an age-based filtering system?',
                            answer:
                                'Yes! You can easily filter toys by age range, from infants (0-12 months) to teens (13+ years). We also provide detailed age recommendations for each toy to ensure appropriate selection.',
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Footer
                  const CustomFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeParagraph() {
    return RichText(
      textAlign: TextAlign.justify,
      text: const TextSpan(
        style: TextStyle(
          fontSize: 16,
          height: 1.6,
          color: Color(0xFF334155),
        ),
        children: [
          TextSpan(text: 'Welcome to '),
          TextSpan(
            text: 'ToyVista',
            style: TextStyle(
              color: Color(0xFF2563EB),
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
              text:
                  ' — your ultimate destination for discovering the best toys online. But what makes ToyVista stand out from the rest?'),
        ],
      ),
    );
  }

  Widget _buildMissionParagraph() {
    return RichText(
      textAlign: TextAlign.justify,
      text: const TextSpan(
        style: TextStyle(
          fontSize: 16,
          height: 1.6,
          color: Color(0xFF334155),
        ),
        children: [
          TextSpan(text: 'At ToyVista, we believe toy shopping should be '),
          TextSpan(
            text: 'fun, fast, and frustration-free',
            style: TextStyle(
              color: Color(0xFF2563EB),
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(text: ". That's why we've built one of the "),
          TextSpan(
            text: 'most well-organized and category-rich toy websites',
            style: TextStyle(
              color: Color(0xFF2563EB),
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
              text:
                  ' on the internet. Instead of digging through thousands of unrelated products, you can jump straight to exactly what you’re looking for — whether it’s '),
          TextSpan(
            text:
                'educational toys, remote-controlled cars, hoverboards, STEM kits',
            style: TextStyle(
              color: Color(0xFF2563EB),
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(text: ', or something else entirely.'),
        ],
      ),
    );
  }

  Widget _buildNavigationParagraph() {
    return RichText(
      textAlign: TextAlign.justify,
      text: const TextSpan(
        style: TextStyle(
          fontSize: 16,
          height: 1.6,
          color: Color(0xFF334155),
        ),
        children: [
          TextSpan(text: 'Our site is designed with '),
          TextSpan(
            text: 'smooth navigation and easy browsing',
            style: TextStyle(
              color: Color(0xFF2563EB),
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
              text:
                  ' in mind. Every toy is placed in a specific subcategory to help you find what you need in seconds, not hours. Whether you’re shopping for a toddler\'s first puzzle or a teenager\'s next tech gadget, '),
          TextSpan(
            text: 'ToyVista makes the search effortless',
            style: TextStyle(
              color: Color(0xFF2563EB),
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(text: '.'),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQCard({
    required String question,
    required String answer,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool _isHovered = false;

        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isHovered
                    ? const Color(0xFF2563EB)
                    : const Color(0xFFDBEAFE),
                width: _isHovered ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.help_outline,
                        color: Color(0xFF2563EB),
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        question,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _isHovered
                              ? const Color(0xFF2563EB)
                              : const Color(0xFF1E293B),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: Text(
                    answer,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
