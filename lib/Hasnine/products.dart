import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final String description;
  final String imageAsset;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.imageAsset,
  });
}

Widget productPhotoOrIcon(Product product, {double? iconSize}) {
  return Image.asset(
    product.imageAsset,
    height: iconSize,
    width: iconSize,
    fit: BoxFit.contain,
  );
}

const List<Product> demoProducts = [
  Product(
    id: 'p1',
    name: 'Fresh Tomatoo (1 kg)',
    category: 'Food',
    price: 70,
    description: 'Fresh, Healthy, Organic Tomatoo',
    imageAsset: 'assets/food.png',
  ),
  Product(
    id: 'p2',
    name: 'Laptop Backpack',
    category: 'Bags',
    price: 2000,
    description: 'Water-resistant backpack with laptop compartment.',
    imageAsset: 'assets/bag.png',
  ),
  Product(
    id: 'p3',
    name: 'T-Shirt',
    category: 'Clothing',
    price: 1500,
    description: 'Lightweight dry-fit t-shirt.',
    imageAsset: 'assets/shirt.png',
  ),
  Product(
    id: 'p4',
    name: 'Galaxy Buds 2',
    category: 'Electronics',
    price: 9000,
    description: 'Noise-isolation earbuds with strong battery life.',
    imageAsset: 'assets/buds.png',
  ),
  Product(
    id: 'p5',
    name: 'Sneakers',
    category: 'Sports',
    price: 1800,
    description: 'For sports and fashion',
    imageAsset: 'assets/sneakers.png',
  ),
  Product(
    id: 'p6',
    name: 'Sunscream',
    category: 'Beauty',
    price: 720,
    description: 'sunscream for protect from sunlight',
    imageAsset: 'assets/beauty.png',
  ),
  Product(
    id: 'p7',
    name: 'Bluetooth Speaker',
    category: 'Electronics',
    price: 4000,
    description: 'Portable speaker with clear sound and bass.',
    imageAsset: 'assets/speaker.png',
  ),
  Product(
    id: 'p8',
    name: 'Wrist Watch',
    category: 'Accessories',
    price: 4000,
    description: 'Simple wrist watch for everyday wear.',
    imageAsset: 'assets/watch.png',
  ),
  Product(
    id: 'p9',
    name: 'Football Boots',
    category: 'Sports',
    price: 3000,
    description: 'Comfortable boots for football practice and matches.',
    imageAsset: 'assets/footballboot.png',
  ),
  Product(
    id: 'p10',
    name: 'Milk (1 liter)',
    category: 'Food',
    price: 90,
    description: 'Fresh milk.',
    imageAsset: 'assets/milk.png',
  ),
  Product(
    id: 'p11',
    name: 'Cotton Hoodie',
    category: 'Clothing',
    price: 1500,
    description: 'Soft hoodie for regular wear in cool weather.',
    imageAsset: 'assets/hoodie.png',
  ),
  Product(
    id: 'p12',
    name: 'Power Bank',
    category: 'Electronics',
    price: 2200,
    description: 'Portable charger with fast charging support.',
    imageAsset: 'assets/powerbank.png',
  ),
  Product(
    id: 'p13',
    name: 'Sunglasses',
    category: 'Accessories',
    price: 1200,
    description: 'Lightweight sunglasses with UV protection.',
    imageAsset: 'assets/sunglasses.png',
  ),
];

final List<Product> popularProducts = [
  demoProducts[0],
  demoProducts[1],
  demoProducts[3],
  demoProducts[12],
  demoProducts[10],
  demoProducts[11],
];
