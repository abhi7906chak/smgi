import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smgi/pages/after_loginOrsignUp/home_src.dart';
import 'package:smgi/utiles/snack_bar.dart';
import 'package:video_player/video_player.dart';

class VerifyEmailSrc extends StatefulWidget {
  // final FirebaseAuth userverifed;

  const VerifyEmailSrc({super.key});

  @override
  State<VerifyEmailSrc> createState() => _VerifyEmailSrcState();
}

class _VerifyEmailSrcState extends State<VerifyEmailSrc> {
  late VideoPlayerController _controller;
  Timer? _timer;
  late var usercred;

  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/Email.mp4")
      ..initialize().then((value) {
        setState(() {});
      });

    _play();
    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) async {
      final user = await auth.currentUser!;
      await user.reload();
      if (user.emailVerified) {
        _timer!.cancel();
        Get.to(() => HomeSrc());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: InkWell(
                      onTap: () async {
                        try {
                          await auth.currentUser!
                              .delete()
                              .then((value) => Get.back());
                        } catch (e) {
                          snack_bar("SomeThing Went Wrong !! ", "Try Again!!",
                              context, ContentType.warning);
                        }
                      },
                      child: const FaIcon(FontAwesomeIcons.chevronLeft),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: VideoPlayer(_controller),
                ),
                RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                      text: "Let's verify you",
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: "Encode",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ]),
                ),
                RichText(
                  text: const TextSpan(
                    text: "A verification mail is sent to your email",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Encode",
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.23,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: FloatingActionButton(
                        child: const FaIcon(FontAwesomeIcons.question),
                        onPressed: () {
                          snack_bar(
                            "Ooh No!",
                            "Go back and Re-sign up.\nIf you've verified your email, wait or try again.",
                            context,
                            ContentType.help,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _play() async {
    _controller.setLooping(true);
    _controller.play();
  }
}
