import 'package:flutter/material.dart';

import 'navigation.dart';
import 'product_description.dart';
import 'products.dart';

class ProductCatagoryPage extends StatelessWidget {
  const ProductCatagoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categoryNames = [
      'Food',
      'Clothing',
      'Electronics',
      'Accessories',
      'Sports',
      'Beauty'
    ];

    final List<IconData> categoryIcons = [
      Icons.restaurant,
      Icons.checkroom_outlined,
      Icons.smartphone,
      Icons.auto_awesome_outlined,
      Icons.sports_cricket_outlined,
      Icons.brush,
    ];

    final List<Color> iconColors = [
      const Color(0xFFE67E22),
      const Color(0xFF6AB04C),
      const Color(0xFF8E44AD),
      const Color(0xFFEB4D4B),
      const Color(0xFF2D98DA),
      const Color(0xFF8E44AD),
    ];

    final List<Color> backgroundColors = [
      const Color(0xFFFFF1E8),
      const Color(0xFFEEF8E8),
      const Color(0xFFF4EAFA),
      const Color(0xFFFFEEEE),
      const Color(0xFFFFEEEE),
      const Color(0xFFEEF8E8),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Category'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: categoryNames.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          String categoryName = categoryNames[index];
          int itemCount = 0;

          for (int i = 0; i < demoProducts.length; i++) {
            if (demoProducts[i].category == categoryName) {
              itemCount++;
            }
          }

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: Color(0xFFE8E8E8)),
            ),
            child: ListTile(
              leading: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: backgroundColors[index],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  categoryIcons[index],
                  color: iconColors[index],
                ),
              ),
              title: Text(categoryName),
              subtitle: Text('$itemCount items'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductListPage(
                      title: '$categoryName Products',
                      categoryFilter: categoryName,
                      navIndex: 1,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomNavBar(selectedIndex: 1),
    );
  }
}
