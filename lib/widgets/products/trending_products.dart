// lib/widgets/products/trending_products.dart
import 'package:flutter/material.dart';
import 'product_card.dart';
import '../../utils/constants.dart';

class TrendingProducts extends StatelessWidget {
  const TrendingProducts({super.key});

  // Expanded product list with 8 items
  final List<Map<String, String>> products = const [
    {
      'title':
          'STEM Robotics Science Kits for Kids Age 8-12 8-10, STEM Toys for Boys Girls 6-8',
      'price': '\$20.99',
      'image': 'https://picsum.photos/seed/robot1/400/400',
    },
    {
      'title':
          'Sillbird STEM 12-in-1 Education Solar Robot Toys for Boys Ages 8-13, DIY Building',
      'price': '\$24.99',
      'image': 'https://picsum.photos/seed/solar1/400/400',
    },
    {
      'title':
          'Teach Tech "Hydrobot Arm Kit", Hydraulic Robot Toys for Boys Ages 8-13',
      'price': '\$55.99',
      'image': 'https://picsum.photos/seed/arm1/400/400',
    },
    {
      'title':
          'STEM Kits for Kids Crafts 6-8 8-12, Boys Gifts Toys for 6-7 Year Old Boy',
      'price': '\$21.99',
      'image': 'https://picsum.photos/seed/craft1/400/400',
    },
    {
      'title':
          'LEGO Technic Bugatti Chiron 42083 Model Car Building Kit for Ages 16+',
      'price': '\$349.99',
      'image': 'https://picsum.photos/seed/lego1/400/400',
    },
    {
      'title': 'Nerf N-Strike Elite Disruptor Blaster - 6-Dart Rotating Drum',
      'price': '\$14.99',
      'image': 'https://picsum.photos/seed/nerf1/400/400',
    },
    {
      'title': 'Hot Wheels Track Builder Unlimited Loop Pack with 1 Toy Car',
      'price': '\$24.99',
      'image': 'https://picsum.photos/seed/hotwheels1/400/400',
    },
    {
      'title':
          'Barbie Dreamhouse Dollhouse with 70+ Pieces Including Furniture',
      'price': '\$189.99',
      'image': 'https://picsum.photos/seed/barbie1/400/400',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          RichText(
            text: const TextSpan(
              text: 'Trending ',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              children: [
                TextSpan(
                  text: 'Products',
                  style: TextStyle(color: toyBlue),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(width: 80, height: 4, color: toyBlue),
          const SizedBox(height: 32),

          // Responsive grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 1200
                  ? 4
                  : MediaQuery.of(context).size.width > 900
                      ? 3
                      : MediaQuery.of(context).size.width > 600
                          ? 2
                          : 1,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(
                title: products[index]['title']!,
                price: products[index]['price']!,
                imageUrl: products[index]['image']!,
              );
            },
          ),
        ],
      ),
    );
  }
}
