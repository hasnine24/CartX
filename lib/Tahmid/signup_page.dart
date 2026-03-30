import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/Hasnine/home_page.dart'; 

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signup() async {
    try {
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await FirebaseFirestore.instance.collection('users').doc(credential.user?.uid).set({
        'uid': credential.user?.uid,
        'name': _nameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'address': _addressController.text.trim(),
        'email': _emailController.text.trim(),
        'createdAt': DateTime.now(),
      });

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'Signup failed.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color brandOrange = Color(0xFFFF7A00);
    const Color navyBlue = Color(0xFF2A324B);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: navyBlue),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Welcome Header ---
            const Text("Join CartX family!", 
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: navyBlue)),
            const SizedBox(height: 8),
            const Text("Create an account to start your shopping journey.", 
              style: TextStyle(fontSize: 15, color: Colors.grey)),
            const SizedBox(height: 35),

            // --- Input Fields ---
            _buildInput(_nameController, "Full Name", Icons.person_outline),
            const SizedBox(height: 18),
            _buildInput(_phoneController, "Phone Number", Icons.phone_android_outlined, type: TextInputType.phone),
            const SizedBox(height: 18),
            _buildInput(_addressController, "Delivery Address", Icons.location_on_outlined),
            const SizedBox(height: 18),
            _buildInput(_emailController, "Email Address", Icons.email_outlined, type: TextInputType.emailAddress),
            const SizedBox(height: 18),
            _buildInput(_passwordController, "Password", Icons.lock_outline, isPass: true),
            const SizedBox(height: 40),

            // --- Signup Button ---
            SizedBox(
              width: double.infinity, height: 55,
              child: ElevatedButton(
                onPressed: _signup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandOrange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 0,
                ),
                child: const Text("Get Started", 
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 25),

            // --- Back to Login ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Login", style: TextStyle(color: navyBlue, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String label, IconData icon, {bool isPass = false, TextInputType type = TextInputType.text}) {
    return TextField(
      controller: controller,
      obscureText: isPass,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFFFF7A00)),
        filled: true,
        fillColor: Colors.grey.shade50,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFFFF7A00), width: 2),
        ),
      ),
    );
  }
}