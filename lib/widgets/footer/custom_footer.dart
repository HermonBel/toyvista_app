import 'package:flutter/material.dart';
import 'footer_brand.dart';
import 'sister_companies.dart';
import 'useful_links.dart';
import 'contact_us.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E293B),
      padding: const EdgeInsets.all(48),
      child: Column(
        children: [
          // Responsive footer grid
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: FooterBrand()),
                    Expanded(child: SisterCompanies()),
                    Expanded(child: UsefulLinks()),
                    Expanded(child: ContactUs()),
                  ],
                );
              } else {
                return const Column(
                  children: [
                    FooterBrand(),
                    SizedBox(height: 32),
                    SisterCompanies(),
                    SizedBox(height: 32),
                    UsefulLinks(),
                    SizedBox(height: 32),
                    ContactUs(),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 32),
          const Divider(color: Color.fromARGB(255, 13, 19, 27)),
          const SizedBox(height: 16),
          const Text(
            '© 2025 ToyVista. All rights reserved | Developed by MarketingEthiopia.com',
            style: TextStyle(color: Colors.grey, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
