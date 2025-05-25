// utiles/splash_src.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smgi/pages/after_loginOrsignUp/home_src.dart';
import 'package:smgi/pages/login_sing_up_page.dart';
import 'package:video_player/video_player.dart';

class SplashSrc extends StatefulWidget {
  const SplashSrc({super.key});

  @override
  State<SplashSrc> createState() => _SplashSrcState();
}

class _SplashSrcState extends State<SplashSrc> {
  final auth = FirebaseAuth.instance;
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/SMGI_logo_light.mp4")
      ..initialize().then((_) {
        setState(() {});
      });
    _play();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white70,
        child: Center(
          child: VideoPlayer(_controller),
          // child: _controller.value.isInitialized
          //     ? VideoPlayer(_controller)
          //     : Container(),
        ),
      ),
    );
  }

  Future<void> _play() async {
    _controller.play();
    await Future.delayed(const Duration(seconds: 7));
    go();
  }

  void go() async {
    final user = auth.currentUser;

    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection("student")
          .doc(user.email)
          .get();

      final data = doc.data();
      final status =
          data?['status']; // ye 'pending', 'approved', etc ho sakta hai

      print("status: $status");

      if (status == "approved") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeSrc(),
          ),
          (route) => false,
        );
      } else {
        // agar status null hai ya pending ho
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginSingUpPage(),
          ),
          (route) => false,
        );
        // snack_bar("Validate First", "Ask you Teacher to validate you soon",
        //     context, ContentType.warning);
      }
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginSingUpPage(),
        ),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
