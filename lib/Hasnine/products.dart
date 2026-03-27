import 'package:flutter/material.dart';

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
    name: 'Fresh Tomatoo',
    category: 'Food',
    price: 120,
    description: 'Fresh, Healthy, Organic Tomatoo',
    color: Colors.orange,
    imageAsset: 'assets/food.png',
  ),
  Product(
    id: 'p2',
    name: 'Office Backpack',
    category: 'Bags',
    price: 54.0,
    description: 'Water-resistant backpack with laptop compartment.',
    color: Colors.blue,
    imageAsset: 'assets/sports.png',
  ),
  Product(
    id: 'p3',
    name: 'T-Shirt',
    category: 'Clothing',
    price: 2400.0,
    description: 'Lightweight dry-fit t-shirt.',
    color: Colors.green,
    imageAsset: 'assets/polo_shirt.png',
  ),
  Product(
    id: 'p4',
    name: 'Wireless Earbuds',
    category: 'Electronics',
    price: 119.0,
    description: 'Noise-isolation earbuds with strong battery life.',
    color: Colors.purple,
    imageAsset: 'assets/food.png',
  ),
  Product(
    id: 'p5',
    name: 'Travel Bottle',
    category: 'Accessories',
    price: 16.0,
    description: 'Leak-proof steel bottle for school, office, and travel.',
    color: Colors.red,
    imageAsset: 'assets/milk.png',
  ),
  Product(
    id: 'p6',
    name: 'Canvas Sneakers',
    category: 'Shoes',
    price: 45.0,
    description: 'Simple canvas sneakers for daily use.',
    color: Colors.teal,
    imageAsset: 'assets/clothing.png',
  ),
  Product(
    id: 'p7',
    name: 'Leather Handbag',
    category: 'Bags',
    price: 72.0,
    description: 'Stylish handbag with enough space for essentials.',
    color: Colors.brown,
    imageAsset: 'assets/sports.png',
  ),
  Product(
    id: 'p8',
    name: 'Denim Jacket',
    category: 'Clothing',
    price: 59.0,
    description: 'Classic denim jacket for a casual outfit.',
    color: Colors.indigo,
    imageAsset: 'assets/clothing.png',
  ),
  Product(
    id: 'p9',
    name: 'Bluetooth Speaker',
    category: 'Electronics',
    price: 38.0,
    description: 'Portable speaker with clear sound and bass.',
    color: Colors.deepPurple,
    imageAsset: 'assets/oil.png',
  ),
  Product(
    id: 'p10',
    name: 'Wrist Watch',
    category: 'Accessories',
    price: 28.0,
    description: 'Simple wrist watch for everyday wear.',
    color: Colors.blueGrey,
    imageAsset: 'assets/egg.png',
  ),
  Product(
    id: 'p11',
    name: 'Football Boots',
    category: 'Shoes',
    price: 95.0,
    description: 'Comfortable boots for football practice and matches.',
    color: Colors.lightGreen,
    imageAsset: 'assets/sports.png',
  ),
  Product(
    id: 'p12',
    name: 'Laptop Bag',
    category: 'Bags',
    price: 41.0,
    description: 'Bag with soft padding for laptop safety.',
    color: Colors.cyan,
    imageAsset: 'assets/milk.png',
  ),
  Product(
    id: 'p13',
    name: 'Cotton Hoodie',
    category: 'Clothing',
    price: 33.0,
    description: 'Soft hoodie for regular wear in cool weather.',
    color: Colors.deepOrange,
    imageAsset: 'assets/clothing.png',
  ),
  Product(
    id: 'p14',
    name: 'Power Bank',
    category: 'Electronics',
    price: 22.0,
    description: 'Portable charger with fast charging support.',
    color: Colors.grey,
    imageAsset: 'assets/oil.png',
  ),
  Product(
    id: 'p15',
    name: 'Sunglasses',
    category: 'Accessories',
    price: 18.0,
    description: 'Lightweight sunglasses with UV protection.',
    color: Colors.amber,
    imageAsset: 'assets/beauty.png',
  ),
];

final List<Product> popularProducts = [
  demoProducts[0],
  demoProducts[1],
  demoProducts[3],
  demoProducts[14],
  demoProducts[10],
  demoProducts[11],
];
