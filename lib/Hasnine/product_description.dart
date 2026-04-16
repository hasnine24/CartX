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
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFF7A00),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: productPhotoOrIcon(product, iconSize: 60),
                ),
              ),
              title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Text(product.category, style: TextStyle(color: Colors.grey.shade600)),
              trailing: Text(
                '৳${product.price.toStringAsFixed(2)}',
                style: const TextStyle(color: Color(0xFFFF7A00), fontWeight: FontWeight.bold, fontSize: 16),
              ),
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
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('wishlist')
        .doc(user.uid)
        .collection('my_items')
        .doc(widget.product.id)
        .get();

    if (!mounted) return;
    setState(() {
      isWishlisted = snapshot.exists;
    });
  }

  Future<void> _toggleWishlist() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

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

    if (!mounted) return;
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
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Product Details', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: accentColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: _toggleWishlist,
            icon: Icon(
              isWishlisted ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(widget.product.imageAsset, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 24),
          Text(widget.product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2A324B))),
          const SizedBox(height: 8),
          Text(
            'Price: ৳${widget.product.price.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: accentColor),
          ),
          const SizedBox(height: 24),
          const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            widget.product.description,
            style: TextStyle(fontSize: 15, color: Colors.grey.shade700, height: 1.5),
          ),
          const SizedBox(height: 24),
          // --- Quantity Portion Re-added ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Quantity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline, size: 30),
                    onPressed: quantity > 1 ? () => setState(() => quantity--) : null,
                    color: accentColor,
                  ),
                  const SizedBox(width: 8),
                  Text('$quantity', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline, size: 30),
                    onPressed: () => setState(() => quantity++),
                    color: accentColor,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 150), 
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Price:', style: TextStyle(fontSize: 16, color: Colors.grey)),
                    Text(
                      '৳${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    onPressed: _addToCart,
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Navigation bar spacing adjusted to be lower
          Container(
            color: Colors.white,
            child: CustomNavBar(selectedIndex: widget.navIndex),
          ),
        ],
      ),
    );
  }
}
