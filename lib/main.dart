import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smgi/home_src.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "home": (context) => const HomeSrc(),
      },
      home: const SplashSrc(),
    );
  }
}
