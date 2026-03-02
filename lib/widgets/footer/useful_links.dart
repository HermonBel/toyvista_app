// lib/widgets/footer/useful_links.dart
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class UsefulLinks extends StatelessWidget {
  final bool compact;

  const UsefulLinks({
    super.key,
    this.compact = false, // Default value
  });

  @override
  Widget build(BuildContext context) {
    final links = [
      'About Us',
      'Privacy Policy',
      'Terms of Service',
      'FAQ',
      'Disclaimer'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Useful Links',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: compact ? 14 : 16,
          ),
        ),
        SizedBox(height: compact ? 12 : 16),
        ...links.map((link) => Padding(
              padding: EdgeInsets.only(bottom: compact ? 6 : 8),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF94A3B8),
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  link,
                  style: TextStyle(
                    fontSize: compact ? 12 : 13,
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
