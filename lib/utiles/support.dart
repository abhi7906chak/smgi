// utiles/support.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CollegeSupportScreen extends StatelessWidget {
  const CollegeSupportScreen({super.key});

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("College Help & Support"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Icon(Icons.school, size: 60, color: Colors.deepPurple),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              "SIR MADANLAL GROUP OF INSTITUTIONS (SMGI)",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              "Etawah, Uttar Pradesh (Affiliated to CSJMU)",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 24),
          _sectionTitle("SUPPORT CONTACT"),
          _supportTile(
            icon: Icons.mail_outline,
            title: "Helpdesk Email",
            subtitle: "info@smgi.org.in",
            onTap: () => _launchUrl("mailto:info@smgi.org.in"),
          ),
          _supportTile(
            icon: Icons.phone,
            title: "College Phone",
            subtitle: "+91-09258325999, 09258326999",
            onTap: () => _launchUrl("tel:+919258325999"),
          ),
          _supportTile(
            icon: Icons.public,
            title: "Official Website",
            subtitle: "https://www.smgi.org.in",
            onTap: () => _launchUrl("https://www.smgi.org.in"),
          ),
          _sectionTitle("OFFICE DEPARTMENTS"),
          _supportTile(
            icon: Icons.person,
            title: "Admission Office",
            subtitle: "admission@smgi.org.in",
            onTap: () => _launchUrl("mailto:admission@smgi.org.in"),
          ),
          _supportTile(
            icon: Icons.event_note,
            title: "Exam Cell",
            subtitle: "exam@smgi.org.in",
            onTap: () => _launchUrl("mailto:exam@smgi.org.in"),
          ),
          _supportTile(
            icon: Icons.location_on,
            title: "Campus Address",
            subtitle: "Alampur Hauz, Agra Road, Etawah -206001 (UP) India",
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }

  Widget _supportTile({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }
}
