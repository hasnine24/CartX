import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'product_list.dart';
import 'search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> popularItems = demoProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(CupertinoIcons.profile_circled),
            Text('Welcome To CartX', style: TextStyle(fontSize: 12)),
            Text('Thamid Hasnine', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SearchPage(navIndex: 0),
                ),
              );
            },
            child: Ink(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 8),
                  Text('Search products...'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 190,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: const LinearGradient(colors: [Color(0xFF2D7C85), Color(0xFF6FAFB6)]),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Special Offer', style: TextStyle(color: Colors.white70)),
                SizedBox(height: 4),
                Text(
                  'Up to 40% OFF',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(
                child: Text('Popular Items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProductListPage(
                        title: 'Popular Items',
                        categoryFilter: null,
                        navIndex: 0,
                        onlyNew: false,
                      ),
                    ),
                  );
                },
                child: const Text('View More'),
              ),
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: popularItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return _PopularItemCard(product: popularItems[index], showNewBadge: false);
            },
          ),
        ],
      ),
    );
  }
}

class _PopularItemCard extends StatelessWidget {
  final Product product;
  final bool showNewBadge;

  const _PopularItemCard({required this.product, required this.showNewBadge});

  String _unit(Product p) {
    if (p.category == 'Shoes') return '1 pair';
    if (p.category == 'Bags') return '1 pc';
    if (p.category == 'Clothing') return '1 piece';
    if (p.category == 'Electronics') return '1 pack';
    return '1 item';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDescriptionPage(product: product, navIndex: 0),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      color: product.color.withOpacity(0.25),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: SizedBox.expand(
                        child: productPhotoOrIcon(product, fit: BoxFit.contain, iconSize: 30),
                      ),
                    ),
                  ),
                  if (showNewBadge)
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B6B),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('NEW', style: TextStyle(color: Colors.white, fontSize: 9)),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                    const SizedBox(height: 1),
                    Text(_unit(product), style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                    const Spacer(),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Color(0xFFEF5350),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}