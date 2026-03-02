import 'package:flutter/material.dart';
import '../widgets/header/custom_header.dart';
import '../widgets/footer/custom_footer.dart';
import '../utils/constants.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

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
                          const Text(
                            'Disclaimer',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Decorative underline
                          Container(
                            width: 60,
                            height: 4,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2563EB), Color(0xFF10B981)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Last Updated
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Text(
                              'Last Updated: April 03, 2025',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF64748B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Affiliate Disclosure
                          _buildSection(
                            title: 'Affiliate Disclosure',
                            content:
                                'ToyVista participates in various affiliate programs, including the AliExpress Affiliate Program, Amazon Associates, eBay Partner Network, and other affiliate programs. We may earn commissions when you make a purchase through our links at no extra cost to you.',
                          ),

                          const SizedBox(height: 32),

                          // Product Information Section
                          _buildSection(
                            title: 'Product Information & Availability',
                            content:
                                'We strive for accuracy in product details, but prices and availability are subject to change. Please verify information on the retailer\'s website before purchasing.',
                          ),

                          const SizedBox(height: 32),

                          // Third-Party Links Section
                          _buildSection(
                            title: 'Third-Party Links',
                            content:
                                'Our site contains links to third-party retailers. We do not control these websites and are not responsible for their content, policies, or transactions.',
                          ),

                          const SizedBox(height: 32),

                          // Liability Disclaimer Section
                          _buildSection(
                            title: 'Liability Disclaimer',
                            content:
                                'ToyVista does not manufacture, sell, or distribute products. Any disputes, defects, or delivery issues should be addressed with the respective retailer or manufacturer.',
                          ),

                          const SizedBox(height: 32),

                          // Age Recommendation Section
                          _buildSection(
                            title: 'Age Recommendation & Safety',
                            content:
                                'Please review the manufacturer\'s age guidelines for toys. ToyVista is not responsible for injuries or safety concerns related to product use.',
                          ),

                          const SizedBox(height: 32),

                          // Changes Section
                          _buildSection(
                            title: 'Changes to This Disclaimer',
                            content:
                                'We may update this disclaimer without notice. Please check this page periodically for changes.',
                          ),

                          const SizedBox(height: 40),

                          // Contact Section
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFFF8FAFC),
                                  Colors.grey[50]!
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Contact Us',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'If you have questions, contact us at:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF475569),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2563EB)
                                            .withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.email,
                                        color: Color(0xFF2563EB),
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    const Text(
                                      'Email:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF334155),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'contact@toyvista.com',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF2563EB),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF10B981)
                                            .withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.language,
                                        color: Color(0xFF10B981),
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    const Text(
                                      'Website:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF334155),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'toyvista.com',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF10B981),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20), // Extra bottom padding
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

  Widget _buildSection({
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22, // Slightly smaller for better proportion
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 15, // Slightly smaller
            height: 1.6,
            color: Color(0xFF475569),
          ),
        ),
      ],
    );
  }
}
