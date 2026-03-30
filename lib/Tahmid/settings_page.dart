import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isNotificationChecked = true;

  @override
  Widget build(BuildContext context) {
    const Color brandOrange = Color(0xFFFF7A00);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Settings", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: brandOrange,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
          ),
          child: CheckboxListTile(
            title: const Text("App Notifications", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text("Receive alerts for orders and offers"),
            secondary: const Icon(Icons.notifications_active, color: brandOrange),
            activeColor: brandOrange,
            value: isNotificationChecked,
            onChanged: (bool? value) => setState(() => isNotificationChecked = value ?? false),
          ),
        ),
      ),
    );
  }
}