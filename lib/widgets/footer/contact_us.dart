// lib/widgets/footer/contact_us.dart
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class ContactUs extends StatelessWidget {
  final bool compact;

  const ContactUs({
    super.key,
    this.compact = false, // Default value
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: compact ? 14 : 16,
          ),
        ),
        SizedBox(height: compact ? 12 : 16),
        const Text(
          'Email: contact@toyvista.com',
          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
        ),
        SizedBox(height: compact ? 16 : 20),
        Row(
          children: [
            _buildSocialIcon(Icons.facebook, compact),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.photo_camera, compact),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.alternate_email, compact),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.play_circle_fill, compact),
          ],
        ),
        SizedBox(height: compact ? 20 : 24),
        if (!compact) ...[
          _buildStoreButton(
            topText: 'Download on the',
            bottomText: 'App Store',
          ),
          const SizedBox(height: 8),
          _buildStoreButton(
            topText: 'Get it on',
            bottomText: 'Google Play',
          ),
        ] else ...[
          Row(
            children: [
              Expanded(
                child: _buildStoreButton(
                  topText: 'App Store',
                  bottomText: 'Download',
                  compact: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStoreButton(
                  topText: 'Google Play',
                  bottomText: 'Get it',
                  compact: true,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, bool compact) {
    return Container(
      width: compact ? 28 : 32,
      height: compact ? 28 : 32,
      decoration: BoxDecoration(
        color: const Color(0xFF1E3A5F),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, size: compact ? 12 : 16, color: Colors.white),
        onPressed: () {},
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }

  Widget _buildStoreButton({
    required String topText,
    required String bottomText,
    bool compact = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F2744),
        border: Border.all(color: const Color(0xFF2D4A6E)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: compact ? 6 : 8,
            horizontal: compact ? 8 : 12,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.download,
              color: const Color(0xFF94A3B8),
              size: compact ? 14 : 16,
            ),
            const SizedBox(width: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topText,
                  style: TextStyle(
                    color: const Color(0xFF94A3B8),
                    fontSize: compact ? 8 : 9,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  bottomText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: compact ? 10 : 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
