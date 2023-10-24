import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeSrc extends StatefulWidget {
  const HomeSrc({super.key});

  @override
  State<HomeSrc> createState() => _HomeSrcState();
}

class _HomeSrcState extends State<HomeSrc> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () async {
              await auth.signOut();
            },
            icon: Icon(Icons.logout))
      ]),
      body: Container(
        color: Colors.amber,
        child: const Center(child: Text("temp home page")),
      ),
    );
  }
}
