// lib/screens/disclaimer_screen.dart
import 'package:flutter/material.dart';
import '../widgets/header/custom_header.dart';
import '../utils/constants.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomHeader(showSearchBar: false), // No search bar
          Expanded(
            child: Center(
              child: Text(
                'Disclaimer Page - Coming Soon!',
                style: TextStyle(fontSize: 24, color: toyBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
