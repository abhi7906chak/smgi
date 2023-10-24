import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smgi/pages/login_page.dart';
import 'package:smgi/pages/login_sing_up_page.dart';
import 'package:smgi/pages/singup_page.dart';
import 'package:smgi/utiles/splash_src.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainSrc());
}

class MainSrc extends StatefulWidget {
  const MainSrc({super.key});

  @override
  State<MainSrc> createState() => _MainSrcState();
}

class _MainSrcState extends State<MainSrc> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "home",
      routes: {
        // "verifyemail": (context) => const VerifyEmailSrc(),
        "singupsrc": (context) => const SingUpPage(),
        "loginsrc": (context) => const LoginPageSrc(),
        "login_singup_page": (context) => const LoginSingUpPage(),
        "home": (context) => const SplashSrc(),
        // "bh":(context) => const LoginSingUpPage(),
      },
    );
  }
}
