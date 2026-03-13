import 'package:flutter/material.dart';

import 'navigation.dart';
import 'products.dart';

class SearchPage extends StatefulWidget {
  final int navIndex;

  const SearchPage({super.key, required this.navIndex});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  List<Product> searchResults = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchProduct(String text) {
    final List<Product> results = [];

    for (final product in demoProducts) {
      if (product.name.toLowerCase().contains(text.toLowerCase())) {
        results.add(product);
      }
    }

    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: searchProduct,
              decoration: InputDecoration(
                hintText: 'Search product...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xFF5FA4AE)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final product = searchResults[index];

                  return Card(
                    child: ListTile(
                      title: Text(product.name),
                      subtitle: Text(product.category),
                      trailing: Text('\$${product.price.toStringAsFixed(2)}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(selectedIndex: widget.navIndex),
    );
  }
}
