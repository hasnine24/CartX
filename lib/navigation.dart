import 'package:flutter/material.dart';

import 'home_page.dart';
import 'product_catagory.dart';

class MainNavigationPage extends StatefulWidget {
  final int initialIndex;

  const MainNavigationPage({super.key, this.initialIndex = 0});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      const ProductCatagoryPage(),
      const _SimplePage(text: 'Cart page is your friend\'s part'),
      const _SimplePage(text: 'Profile page is your friend\'s part'),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
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

class _SimplePage extends StatelessWidget {
  final String text;

  const _SimplePage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text));
  }
}
