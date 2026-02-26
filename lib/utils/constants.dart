import 'package:flutter/material.dart';

// ============= COLORS =============
const Color toyBlue = Color(0xFF1E40AF);
const Color toyYellow = Color(0xFFFBBF24);
const Color toyGreen = Color(0xFF10B981);
const Color toyDark = Color(0xFF0F172A);
const Color toyDarkLight = Color(0xFF1E293B);
const Color toySlate = Color(0xFF334155);
const Color toyBackground = Color(0xFFF8FAFC);

// ============= HEADER GRADIENT =============
const LinearGradient headerGradient = LinearGradient(
  colors: [Color(0xFFBAE6FD), Color(0xFFBBF7D0)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

// ============= PRODUCT DATA =============
const List<Map<String, String>> products = [
  {
    'title':
        'STEM Robotics Science Kits for Kids Age 8-12 8-10, STEM Toys for Boys Girls 6-8',
    'price': '\$20.99',
    'image': 'https://picsum.photos/seed/robot/400/400',
  },
  {
    'title':
        'Sillbird STEM 12-in-1 Education Solar Robot Toys for Boys Ages 8-13, DIY Building',
    'price': '\$24.99',
    'image': 'https://picsum.photos/seed/solar/400/400',
  },
  {
    'title':
        'Teach Tech "Hydrobot Arm Kit", Hydraulic Kit, STEM Building Toy for Kids 12+',
    'price': '\$55.99',
    'image': 'https://picsum.photos/seed/arm/400/400',
  },
  {
    'title':
        'STEM Kits for Kids Crafts 6-8 8-12, Boys Gifts Toys for 6 7 Year Old Boy Birthday',
    'price': '\$21.99',
    'image': 'https://picsum.photos/seed/craft/400/400',
  },
];

// ============= CATEGORIES DATA =============
const List<Map<String, dynamic>> categories = [
  {'name': 'Educational Toys', 'popular': true},
  {'name': 'Educational Tablets', 'popular': true},
  {'name': 'LEGO Toys', 'popular': true},
  {'name': 'Coding Robots', 'popular': true},
  {'name': 'Superhero Costumes', 'popular': true},
  {'name': 'Hoverboards', 'popular': true},
  {'name': 'Skateboards', 'popular': true},
  {'name': 'Electric Skateboards', 'popular': true},
  {'name': 'Roller Skates', 'popular': false},
  {'name': 'Skate Shoes', 'popular': false},
  {'name': 'Scooters', 'popular': false},
  {'name': 'Electric Scooters', 'popular': false},
  {'name': 'Bicycles', 'popular': false},
  {'name': 'Remote Control Toys', 'popular': false},
  {'name': 'Drones', 'popular': false},
];

// ============= BLOGS DATA =============
const List<Map<String, String>> blogs = [
  {
    'title': 'Bloks - Which Building Toy Reigns Supreme?',
    'date': 'Apr 15, 2025',
    'image': 'https://picsum.photos/seed/blog1/600/400',
  },
  {
    'title': 'Growing Minds: The Power of Educational Toys',
    'date': 'Apr 15, 2025',
    'image': 'https://picsum.photos/seed/blog2/600/400',
  },
  {
    'title': 'Child\'s Age: How to Pick the Perfect Toy',
    'date': 'Apr 15, 2025',
    'image': 'https://picsum.photos/seed/blog3/600/400',
  },
];

// ============= FOOTER DATA =============
const List<String> sisterCompanies = [
  'Wellness World',
  'iShoez',
  'DGPick',
  'Electronixa',
];

const List<String> usefulLinks = [
  'About Us',
  'Privacy Policy',
  'Terms of Service',
  'FAQ',
  'Disclaimer',
];
