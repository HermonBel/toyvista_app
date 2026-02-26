import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class SisterCompanies extends StatelessWidget {
  const SisterCompanies({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sister Companies',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        ...sisterCompanies.map(
          (company) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
                padding: EdgeInsets.zero,
              ),
              child: Text(company),
            ),
          ),
        ),
      ],
    );
  }
}
