import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';
import 'my_orders_page.dart';
import 'wishlist_page.dart';
import 'edit_profile_page.dart';
import 'contact_us_page.dart';
import 'settings_page.dart';
import '../Hasnine/navigation.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Logout function
  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    const Color brandOrange = Color(0xFFFF7A00);
    const Color navyBlue = Color(0xFF2A324B);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: brandOrange,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Top Section: Profile Header ---
            Container(
              width: double.infinity,
              color: brandOrange,
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection('users').doc(user?.uid).snapshots(),
                builder: (context, snapshot) {
                  String userName = "User Name";
                  if (snapshot.hasData && snapshot.data!.exists) {
                    userName = snapshot.data!['name'] ?? "User Name";
                  }
                  return Column(
                    children: [
                      const CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 50, color: Colors.grey),
                      ),
                      const SizedBox(height: 15),
                      Text(userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text(user?.email ?? "", style: const TextStyle(fontSize: 14, color: Colors.white70)),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // --- Menu Options ---
            _menuTile(Icons.shopping_bag_outlined, "My Orders", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const MyOrdersPage()));
            }),
            _menuTile(Icons.favorite_border, "Wishlist", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const WishlistPage()));
            }),
            _menuTile(Icons.edit_outlined, "Edit Profile", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfilePage()));
            }),
            
            const Divider(height: 30, thickness: 1, indent: 20, endIndent: 20),

            _menuTile(Icons.settings_outlined, "Settings", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
            }),
            _menuTile(Icons.headset_mic_outlined, "Contact Us", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactUsPage()));
            }),

            const SizedBox(height: 30),

            // --- Logout Button ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => _logout(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Logout", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(selectedIndex: 3),
    );
  }

  Widget _menuTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFFF7A00)),
      title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}