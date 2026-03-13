import 'package:flutter/material.dart';
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
              leading: CircleAvatar(
                backgroundColor: product.color.withOpacity(0.2),
                child: productPhotoOrIcon(product, iconSize: 20),
              ),
              title: Text(product.name),
              subtitle: Text(product.category),
              trailing: Text('\৳${product.price.toStringAsFixed(2)}'),
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

  @override
  Widget build(BuildContext context) {
    double total = widget.product.price * quantity;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: widget.product.color.withOpacity(0),
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
            '\৳${widget.product.price.toStringAsFixed(2)}',
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
            'Total: \৳${total.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
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
