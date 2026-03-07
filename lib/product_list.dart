import 'package:flutter/material.dart';

import 'navigation.dart';

class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final String description;
  final Color color;
  final String imageAsset;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.color,
    required this.imageAsset,
  });
}

Widget productPhotoOrIcon(Product product, {double iconSize = 32, BoxFit fit = BoxFit.contain}) {
  return Image.asset(
    product.imageAsset,
    width: double.infinity,
    height: double.infinity,
    fit: fit,
    errorBuilder: (_, __, ___) => Center(
      child: Icon(Icons.image_not_supported, color: Colors.grey, size: iconSize),
    ),
  );
}

const List<Product> demoProducts = [
  Product(
    id: 'p1',
    name: 'Running Shoes',
    category: 'Shoes',
    price: 89.0,
    description: 'Comfortable shoes for daily running and casual use.',
    color: Colors.orange,
    imageAsset: 'assets/products/food.png',
  ),
  Product(
    id: 'p2',
    name: 'Office Backpack',
    category: 'Bags',
    price: 54.0,
    description: 'Water-resistant backpack with laptop compartment.',
    color: Colors.blue,
    imageAsset: 'assets/products/sports.png',
  ),
  Product(
    id: 'p3',
    name: 'Sport T-Shirt',
    category: 'Clothing',
    price: 24.0,
    description: 'Lightweight dry-fit t-shirt for workouts.',
    color: Colors.green,
    imageAsset: 'assets/products/beauty.png',
  ),
  Product(
    id: 'p4',
    name: 'Wireless Earbuds',
    category: 'Electronics',
    price: 119.0,
    description: 'Noise-isolation earbuds with strong battery life.',
    color: Colors.purple,
    imageAsset: 'assets/products/food.png',
  ),
  Product(
    id: 'p5',
    name: 'Travel Bottle',
    category: 'Accessories',
    price: 16.0,
    description: 'Leak-proof steel bottle for school, office, and travel.',
    color: Colors.red,
    imageAsset: 'assets/products/milk.png',
  ),
];

class ProductListPage extends StatelessWidget {
  final String title;
  final String? categoryFilter;
  final int navIndex;
  final bool onlyNew;

  const ProductListPage({
    super.key,
    required this.title,
    required this.categoryFilter,
    required this.navIndex,
    this.onlyNew = false,
  });

  List<Product> _getItems() {
    final List<Product> items = [];

    if (onlyNew) {
      for (int i = 0; i < demoProducts.length && i < 3; i++) {
        items.add(demoProducts[i]);
      }
      return items;
    }

    if (categoryFilter == null) {
      for (final product in demoProducts) {
        items.add(product);
      }
      return items;
    }

    for (final product in demoProducts) {
      if (product.category == categoryFilter) {
        items.add(product);
      }
    }

    return items;
  }

  void _goToMainTab(BuildContext context, int index) {
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
    final List<Product> items = _getItems();

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final product = items[index];

          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDescriptionPage(
                      product: product,
                      navIndex: navIndex,
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
          );
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navIndex,
        onDestinationSelected: (index) => _goToMainTab(context, index),
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

class ProductDescriptionPage extends StatefulWidget {
  final Product product;
  final int navIndex;

  const ProductDescriptionPage({
    super.key,
    required this.product,
    required this.navIndex,
  });

  @override
  State<ProductDescriptionPage> createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends State<ProductDescriptionPage> {
  int quantity = 1;

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
    final total = (widget.product.price * quantity).toStringAsFixed(2);

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: widget.product.color.withOpacity(0.25),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox.expand(
                child: productPhotoOrIcon(widget.product, fit: BoxFit.contain, iconSize: 90),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(widget.product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(widget.product.category),
          const SizedBox(height: 8),
          Text('\$${widget.product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(widget.product.description),
          const SizedBox(height: 18),
          Row(
            children: [
              const Text('Quantity:'),
              const SizedBox(width: 12),
              IconButton(
                onPressed: quantity > 1
                    ? () {
                        setState(() {
                          quantity--;
                        });
                      }
                    : null,
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Text('$quantity'),
              IconButton(
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                },
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
          Text('Total: \$$total', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${widget.product.name} x$quantity added to cart')),
              );
            },
            child: const Text('Add to Cart'),
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