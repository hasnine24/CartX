import 'package:flutter/material.dart';

import 'navigation.dart';
import 'product_list.dart';

class SearchPage extends StatefulWidget {
  final int navIndex;

  const SearchPage({super.key, required this.navIndex});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Product> _searchProducts(String queryText) {
    final List<Product> results = [];

    final query = queryText.trim().toLowerCase();

    if (query.isEmpty) {
      return results;
    }

    for (final product in demoProducts) {
      final name = product.name.toLowerCase();
      if (name.contains(query)) {
        results.add(product);
      }
    }

    return results;
  }

  void _goToMainTab(int index) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => MainNavigationPage(initialIndex: index),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = _controller.text;
    final List<Product> filteredProducts = _searchProducts(query);

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _controller,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 12),
          if (query.trim().isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text('Type product name to search'),
              ),
            ),
          if (query.trim().isNotEmpty && filteredProducts.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text('No product found'),
              ),
            ),
          for (final product in filteredProducts)
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDescriptionPage(
                        product: product,
                        navIndex: widget.navIndex,
                      ),
                    ),
                  );
                },
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: product.color.withOpacity(0.2),
                  child: ClipOval(
                    child: SizedBox.expand(
                      child: productPhotoOrIcon(product, fit: BoxFit.contain, iconSize: 20),
                    ),
                  ),
                ),
                title: Text(product.name),
                subtitle: Text(product.category),
                trailing: Text('\$${product.price.toStringAsFixed(0)}'),
              ),
            ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.navIndex,
        onDestinationSelected: _goToMainTab,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.category_outlined), label: 'Category'),
          NavigationDestination(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}