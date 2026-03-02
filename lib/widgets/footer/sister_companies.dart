// lib/widgets/footer/sister_companies.dart
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class SisterCompanies extends StatelessWidget {
  final bool compact;

  const SisterCompanies({
    super.key,
    this.compact = false, // Default value
  });

  @override
  Widget build(BuildContext context) {
    final companies = ['Wellness World', 'iShoez', 'DGPick', 'Electronixa'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sister Companies',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: compact ? 14 : 16,
          ),
        ),
        SizedBox(height: compact ? 12 : 16),
        ...companies.map((company) => Padding(
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
                  company,
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
