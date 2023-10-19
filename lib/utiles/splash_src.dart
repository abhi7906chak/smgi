import 'package:flutter/material.dart';
import 'package:smgi/home_src.dart';
import 'package:video_player/video_player.dart';

class SplashSrc extends StatefulWidget {
  const SplashSrc({super.key});

  @override
  State<SplashSrc> createState() => _SplashSrcState();
}

class _SplashSrcState extends State<SplashSrc> {
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
    return Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller))
          : Container(),
    );
  }

  Future<void> _play() async {
    _controller.play();
    await Future.delayed(const Duration(seconds: 8));
    go();
  }

  void go() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeSrc(),
        ),
        (route) => false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}
