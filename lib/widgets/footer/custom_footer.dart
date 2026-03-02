// lib/widgets/footer/custom_footer.dart
import 'package:flutter/material.dart';
import 'footer_brand.dart';
import 'sister_companies.dart';
import 'useful_links.dart';
import 'contact_us.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      color: const Color(0xFF0A1929), // Darker blue-black color
      padding: const EdgeInsets.all(48),
      child: Column(
        children: [
          // Responsive footer grid
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                // Desktop: 4 columns
                return const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: FooterBrand()),
                    Expanded(child: SisterCompanies()),
                    Expanded(child: UsefulLinks()),
                    Expanded(child: ContactUs()),
                  ],
                );
              } else if (constraints.maxWidth > 600) {
                // Tablet: 2 rows of 2 columns
                return Column(
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: FooterBrand()),
                        Expanded(child: SisterCompanies()),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: UsefulLinks()),
                        Expanded(child: ContactUs()),
                      ],
                    ),
                  ],
                );
              } else {
                // Mobile: Stacked with compact sections
                return Column(
                  children: [
                    const FooterBrand(),
                    const SizedBox(height: 30),

                    // Compact row for Sister Companies and Useful Links on mobile
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(
                            0xFF0F2744), // Slightly lighter blue for contrast
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: SisterCompanies(compact: true)),
                          Container(
                            width: 1,
                            height: 120,
                            color: const Color(0xFF2D4A6E),
                          ),
                          Expanded(child: UsefulLinks(compact: true)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                    const ContactUs(compact: true),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 32),

          // Divider
          Container(
            height: 1,
            color: const Color(0xFF1E3A5F), // Dark blue divider
          ),

          const SizedBox(height: 16),

          // Copyright
          const Text(
            '© 2026 ToyVista. All rights reserved | Developed by MarketingEthiopia.com',
            style: TextStyle(color: Color(0xFF6B8AAB), fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
