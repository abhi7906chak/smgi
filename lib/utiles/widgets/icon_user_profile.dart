import 'dart:ui';

import 'package:flutter/material.dart';

class IconUserProfile extends StatefulWidget {
  const IconUserProfile({super.key});

  @override
  State<IconUserProfile> createState() => _IconUserProfileState();
}

class _IconUserProfileState extends State<IconUserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
        children: [
          Text("data" * 1000),
          Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  alignment: Alignment.center,
                  height: 200,
                  width: 200,
                  child: Text("blur"),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
