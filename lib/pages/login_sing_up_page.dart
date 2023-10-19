import 'package:flutter/material.dart';

class LoginSingUpPage extends StatefulWidget {
  const LoginSingUpPage({super.key});

  @override
  State<LoginSingUpPage> createState() => _LoginSingUpPageState();
}

class _LoginSingUpPageState extends State<LoginSingUpPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 110,
              width: 212,
              child: Image.asset("assets/image/logo.gif"),
              // color: Colors.amber,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Welcome to SMGI",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Encode",
                  color: Color(0xFF161697),
                  decoration: TextDecoration.none),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "LET ACCESS ALL WORK FROM HERE",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Encode",
                  color: Colors.black,
                  decoration: TextDecoration.none),
            ),
            const SizedBox(
              height: 28,
            ),
            Container(
              height: 40.5,
              width: 119.5,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(21),
                // color: Colors.amberAccent,
              ),
              child: const Center(
                  child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 23,
                  fontFamily: "Encode",
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                  color: Color(0xFF161697),
                ),
              )),
            ),
            const SizedBox(
              height: 36,
            ),
            Container(
              height: 40.5,
              width: 119.5,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(21),
                // color: Colors.amberAccent,
              ),
              child: const Center(
                  child: Text(
                "Sign up",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Encode",
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                  color: Color(0xFF161697),
                ),
              )),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                child: Image.asset("assets/image/0.png"),
                // height: MediaQuery.of(context).size.height,
              ),
            )
          ],
        ),
      ),
    );
  }
}
