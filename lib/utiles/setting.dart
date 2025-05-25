// utiles/setting.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StaticSettingsScreen extends StatelessWidget {
  const StaticSettingsScreen({super.key});

  Future<DocumentSnapshot<Map<String, dynamic>>> getStudentData() async {
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    return FirebaseFirestore.instance
        .collection('student')
        .doc(userEmail)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getStudentData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("No user data found."));
          }

          final data = snapshot.data!.data()!;
          final name = data['name'] ?? 'No Name';
          final email = data['email'] ?? 'No Email';
          final imageUrl =
              data['photourl'] ?? 'https://via.placeholder.com/150';

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(imageUrl),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Center(child: Text(email)),
              const SizedBox(height: 24),
              _sectionTitle("GENERAL"),
              _tile(
                icon: Icons.dark_mode,
                title: "Dark Mode",
                trailing: Switch(value: false, onChanged: (v) {}),
              ),
              _tile(
                icon: Icons.notifications,
                title: "Notifications",
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
              _sectionTitle("ACCOUNT"),
              _tile(
                icon: Icons.person,
                title: "Profile Info",
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
              _tile(
                icon: Icons.lock,
                title: "Change Password",
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
              _tile(
                icon: Icons.privacy_tip,
                title: "Privacy Policy",
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
              _sectionTitle("OTHERS"),
              _tile(
                icon: Icons.help,
                title: "Help & Support",
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
              _tile(
                icon: Icons.logout,
                title: "Log Out",
                color: Colors.red,
                trailing: const Icon(Icons.logout, size: 20, color: Colors.red),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child:
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
    );
  }

  Widget _tile({
    required IconData icon,
    required String title,
    Widget? trailing,
    Color? color,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      leading: Icon(icon, color: color ?? Colors.deepPurple),
      title: Text(title),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}
