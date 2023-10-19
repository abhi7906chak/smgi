// ignore_for_file: file_names

import 'package:flutter/material.dart';

class HomeSrc extends StatefulWidget {
  const HomeSrc({super.key});

  @override
  State<HomeSrc> createState() => _HomeSrcState();
}

class _HomeSrcState extends State<HomeSrc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.amberAccent,
      ),
    );
  }
}
