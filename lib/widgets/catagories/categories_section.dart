// lib/widgets/categories/categories_section.dart
import 'package:flutter/material.dart';
import 'category_pill.dart';
import '../../utils/constants.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  // Organized categories by type
  final List<Map<String, dynamic>> categories = const [
    // Row 1 - Popular Categories
    {'name': 'Educational Toys', 'popular': true, 'row': 1},
    {'name': 'Hoverboards', 'popular': true, 'row': 1},
    {'name': 'Scooters', 'popular': true, 'row': 1},
    {'name': 'Drones with Camera', 'popular': true, 'row': 1},
    {'name': 'Virtual Reality (VR)', 'popular': true, 'row': 1},
    {'name': 'Action Figures', 'popular': true, 'row': 1},

    // Row 2 - Gaming & Tech
    {'name': 'Gaming Laptops', 'popular': false, 'row': 2},
    {'name': 'Gaming Desktops', 'popular': false, 'row': 2},
    {'name': 'Gamer Consoles', 'popular': false, 'row': 2},
    {'name': 'Gaming Consoles', 'popular': false, 'row': 2},
    {'name': 'Remote Control Toys', 'popular': false, 'row': 2},
    {'name': 'Electric Water Guns', 'popular': false, 'row': 2},

    // Row 3 - Classic Toys
    {'name': 'Dolls & Dollhouses', 'popular': false, 'row': 3},
    {'name': 'Stuffed Animals', 'popular': false, 'row': 3},
    {'name': 'Plush Toys', 'popular': false, 'row': 3},
    {'name': 'Board Games', 'popular': false, 'row': 3},
    {'name': 'Puzzles', 'popular': false, 'row': 3},
    {'name': 'Construction Toys', 'popular': false, 'row': 3},

    // Row 4 - Outdoor & Ride-Ons
    {'name': 'Ride-On Vehicles', 'popular': false, 'row': 4},
    {'name': 'Bicycles', 'popular': false, 'row': 4},
    {'name': 'Roller Skates', 'popular': false, 'row': 4},
    {'name': 'Water Guns', 'popular': false, 'row': 4},
    {'name': 'Electric Scooters', 'popular': false, 'row': 4},
    {'name': 'Skateboards', 'popular': false, 'row': 4},

    // Row 5 - Building & Construction
    {'name': 'LEGO Toys', 'popular': true, 'row': 5},
    {'name': 'Building Blocks', 'popular': false, 'row': 5},
    {'name': 'Magnetic Tiles', 'popular': false, 'row': 5},
    {'name': 'Engineering Kits', 'popular': false, 'row': 5},
    {'name': 'Robot Kits', 'popular': false, 'row': 5},
    {'name': 'Coding Robots', 'popular': true, 'row': 5},
  ];

  @override
  Widget build(BuildContext context) {
    // Group categories by row
    final Map<int, List<Map<String, dynamic>>> groupedCategories = {};
    for (var cat in categories) {
      int row = cat['row'];
      if (!groupedCategories.containsKey(row)) {
        groupedCategories[row] = [];
      }
      groupedCategories[row]!.add(cat);
    }

    return Column(
      children: [
        // Dark background ONLY for the title
        Container(
          width: double.infinity,
          color: toyDark,
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
          child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'Choose Toys from the ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w300),
                children: [
                  TextSpan(
                    text: 'Categories',
                    style: TextStyle(
                        color: toyBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 36),
                  ),
                  TextSpan(
                    text: ' below',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Categories Grid - White background
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
          child: Column(
            children: [
              // Categories Grid - Multiple rows with 6 columns each
              ...List.generate(groupedCategories.keys.length, (rowIndex) {
                int rowNumber = groupedCategories.keys.elementAt(rowIndex);
                List<Map<String, dynamic>> rowCategories =
                    groupedCategories[rowNumber]!;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: rowCategories
                        .map(
                          (cat) => Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: CategoryPill(
                                name: cat['name'],
                                isPopular: cat['popular'],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
