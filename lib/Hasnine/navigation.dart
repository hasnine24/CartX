import 'package:flutter/material.dart';
import '../Tahmid/profile_page.dart';
import '../Waseq/cart_page.dart';
import 'home_page.dart';
import 'product_catagory.dart';


const List<IconData> navIcons = [
  Icons.home_outlined,
  Icons.category_outlined,
  Icons.shopping_cart_outlined,
  Icons.person_outline,
];

const List<String> navTitles = [
  'Home',
  'Category',
  'Cart',
  'Profile',
];

class MainNavigationPage extends StatelessWidget {
  final int initialIndex;

  const MainNavigationPage({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    if (initialIndex == 0) {
      return const HomePage();
    }

    if (initialIndex == 1) {
      return const ProductCatagoryPage();
    }

    if (initialIndex == 2) {
      return const CartPage();
    }
    if (initialIndex == 3) {
       return const ProfilePage();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(
        child: Text(
          'Profile Page',
          style: TextStyle(fontSize: 22),
        ),
      ),
      bottomNavigationBar: const CustomNavBar(selectedIndex: 3),
    );
    return const HomePage();
  }
}

void openNavPage(BuildContext context, int index) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => MainNavigationPage(initialIndex: index),
    ),
    (route) => false,
  );
}

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;

  const CustomNavBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    List<Widget> navItems = [];

    for (int index = 0; index < navIcons.length; index++) {
      bool isSelected = selectedIndex == index;

      navItems.add(
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            if (isSelected) {
              return;
            }

            openNavPage(context, index);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  navIcons[index],
                  color: isSelected ? Colors.deepOrange : Colors.grey,
                ),
                const SizedBox(height: 4),
                Text(
                  navTitles[index],
                  style: TextStyle(
                    fontSize: 10,
                    color: isSelected ? Colors.deepOrange : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      height: 70,
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: navItems,
      ),
    );
  }
}
