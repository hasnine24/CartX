import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'navigation.dart';
import 'products.dart';
import '../Waseq/cart_manager.dart';

class ProductListPage extends StatelessWidget {
  final String title;
  final String? categoryFilter;
  final int navIndex;

  const ProductListPage({
    super.key,
    required this.title,
    required this.categoryFilter,
    required this.navIndex,
  });

  @override
  Widget build(BuildContext context) {
    List<Product> products = [];

    if (categoryFilter == null) {
      products = demoProducts;
    } else {
      for (int i = 0; i < demoProducts.length; i++) {
        if (demoProducts[i].category == categoryFilter) {
          products.add(demoProducts[i]);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          Product product = products[index];

          return Card(
            child: ListTile(
              leading: SizedBox(
                width: 70,
                height: 70,
                child: productPhotoOrIcon(product, iconSize: 70),
              ),
              title: Text(product.name),
              subtitle: Text(product.category),
              trailing: Text('৳${product.price.toStringAsFixed(2)}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProductDescriptionPage(
                        product: product,
                        navIndex: navIndex,
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: CustomNavBar(selectedIndex: navIndex),
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

  void _addToCart() {
    final existingIndex = globalCart.indexWhere(
      (item) => item.product.name == widget.product.name,
    );

    if (existingIndex >= 0) {
      globalCart[existingIndex].quantity += quantity;
    } else {
      globalCart.add(
        CartItem(
          product: widget.product,
          quantity: quantity,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double total = widget.product.price * quantity;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.red),
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                await FirebaseFirestore.instance
                    .collection('wishlist')
                    .doc(user.uid)
                    .collection('my_items')
                    .doc(widget.product.id.toString())
                    .set({
                  'id': widget.product.id,
                  'name': widget.product.name,
                  'price': widget.product.price,
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${widget.product.name} added to Wishlist!")),
                );
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: productPhotoOrIcon(widget.product, iconSize: 90),
          ),
          const SizedBox(height: 16),
          Text(
            widget.product.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(widget.product.category),
          const SizedBox(height: 6),
          Text(
            '৳${widget.product.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(widget.product.description),
          const SizedBox(height: 20),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (quantity > 1) {
                    setState(() {
                      quantity = quantity - 1;
                    });
                  }
                },
                icon: const Icon(Icons.remove),
              ),
              Text('$quantity'),
              IconButton(
                onPressed: () {
                  setState(() {
                    quantity = quantity + 1;
                  });
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Total: ৳${total.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _addToCart();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${widget.product.name} x$quantity added to cart'),
                ),
              );
            },
            child: const Text('Add to Cart'),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(selectedIndex: widget.navIndex),
    );
  }
}

