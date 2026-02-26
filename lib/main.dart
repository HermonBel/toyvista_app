import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/blogs_screen.dart';
import 'screens/why_toy_vista_screen.dart';
import 'screens/disclaimer_screen.dart';
import 'utils/theme.dart';

void main() {
  runApp(const ToyVistaApp());
}

class ToyVistaApp extends StatelessWidget {
  const ToyVistaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToyVista',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/blogs': (context) => const BlogsScreen(),
        '/why-toy-vista': (context) => const WhyToyVistaScreen(),
        '/disclaimer': (context) => const DisclaimerScreen(),
      },
    );
  }
}
