import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Waseq/cart_manager.dart';
import 'navigation.dart';
import 'products.dart';

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
    final List<Product> products = categoryFilter == null
        ? demoProducts
        : demoProducts
            .where((product) => product.category == categoryFilter)
            .toList();

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

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
                    builder: (_) => ProductDescriptionPage(
                      product: product,
                      navIndex: navIndex,
                    ),
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
  bool isWishlisted = false;

  @override
  void initState() {
    super.initState();
    _loadWishlistState();
  }

  Future<void> _loadWishlistState() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    final snapshot = await FirebaseFirestore.instance
        .collection('wishlist')
        .doc(user.uid)
        .collection('my_items')
        .doc(widget.product.id)
        .get();

    if (!mounted) {
      return;
    }

    setState(() {
      isWishlisted = snapshot.exists;
    });
  }

  Future<void> _toggleWishlist() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to use the wishlist.')),
      );
      return;
    }

    final docRef = FirebaseFirestore.instance
        .collection('wishlist')
        .doc(user.uid)
        .collection('my_items')
        .doc(widget.product.id);

    if (isWishlisted) {
      await docRef.delete();
    } else {
      await docRef.set({
        'id': widget.product.id,
        'name': widget.product.name,
        'price': widget.product.price,
        'category': widget.product.category,
        'imageAsset': widget.product.imageAsset,
      });
    }

    if (!mounted) {
      return;
    }

    setState(() {
      isWishlisted = !isWishlisted;
    });
  }

  void _addToCart() {
    final existingIndex = globalCart.indexWhere(
      (item) => item.product.name == widget.product.name,
    );

    if (existingIndex >= 0) {
      globalCart[existingIndex].quantity += quantity;
    } else {
      globalCart.add(
        CartItem(product: widget.product, quantity: quantity),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.product.name} x$quantity added to cart'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.product.price * quantity;
    const accentColor = Color(0xFFFF7A00);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            onPressed: _toggleWishlist,
            icon: Icon(
              isWishlisted ? Icons.favorite : Icons.favorite_border,
              color: accentColor,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                widget.product.imageAsset,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.product.name,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Price: ৳${widget.product.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: accentColor,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.product.description,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Quantity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: quantity > 1
                        ? () {
                            setState(() {
                              quantity--;
                            });
                          }
                        : null,
                    icon: const Icon(Icons.remove),
                    color: accentColor,
                  ),
                  Text(
                    '$quantity',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    icon: const Icon(Icons.add),
                    color: accentColor,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Total Price: ৳${totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: accentColor,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _addToCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Add to Cart',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(selectedIndex: widget.navIndex),
    );
  }
}
