import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smgi/pages/after_loginOrsignUp/Verify%20Email/verify_email.dart';
import 'package:smgi/pages/after_loginOrsignUp/home_src.dart';
import 'package:smgi/pages/forget_pass/password.dart';
import 'package:smgi/pages/login_page.dart';
import 'package:smgi/pages/login_sing_up_page.dart';
import 'package:smgi/pages/shimmer_pages/Homesrc_shimmer.dart';
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
      initialRoute: "loginsrc",
      routes: {
        // "tempatten": (context) => TempAtten(datesheet: datesheet)
        "HomeSrcShimmer": (context) => const HomeSrcShimmer(),
        "homesrc": (context) => const HomeSrc(),
        "for": (context) => const FpassWord(),
        "verifyemail": (context) => const VerifyEmailSrc(),
        "singupsrc": (context) => const SingUpPage(),
        "loginsrc": (context) => const LoginPageSrc(),
        "login_singup_page": (context) => const LoginSingUpPage(),
        "home": (context) => const SplashSrc(),
        // "bh":(context) => const LoginSingUpPage(),
      },
    );
  }
}
