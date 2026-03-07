import 'package:flutter/material.dart';

import 'product_list.dart';

class ProductCatagoryPage extends StatelessWidget {
  const ProductCatagoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [];

    for (final product in demoProducts) {
      if (!categories.contains(product.category)) {
        categories.add(product.category);
      }
    }

    categories.sort();

    return Scaffold(
      appBar: AppBar(title: const Text('Product Category')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return Card(
            child: ListTile(
              title: Text(category),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductListPage(
                      title: '$category Products',
                      categoryFilter: category,
                      navIndex: 1,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}