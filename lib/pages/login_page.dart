import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smgi/pages/after_loginOrsignUp/home_src.dart';
import 'package:smgi/utiles/snack_bar.dart';

class LoginPageSrc extends StatefulWidget {
  const LoginPageSrc({super.key});

  @override
  State<LoginPageSrc> createState() => _LoginPageSrcState();
}

class _LoginPageSrcState extends State<LoginPageSrc> {
  final _formkey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final googleIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                      // Navigator.pop(context);
                    },
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        height: 30,
                        width: 32,
                        child: Image.asset("assets/image/back.png"),
                        // color: Colors.amber,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 110,
                  width: 212,
                  child: Image.asset("assets/image/logo.gif"),
                  // color: Colors.amber,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Welcome to SMGI",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Encode",
                        color: Color(0xFF161697),
                        decoration: TextDecoration.none),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "LET ACCESS ALL WORK FROM HERE",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Encode",
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  // onHover: (value) {
                  //   Colors.accents;
                  // },
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  child: SizedBox(
                      height: 40,
                      width: 42,
                      child: Image.asset("assets/image/google.png")),
                  onPressed: () async {
                    GoogleSignInAccount? usercred = await googleIn.signIn();
                    GoogleSignInAuthentication? userauth =
                        await usercred?.authentication;
                    AuthCredential cred = GoogleAuthProvider.credential(
                      accessToken: userauth?.accessToken,
                      idToken: userauth?.idToken,
                    );
                    UserCredential user = await auth.signInWithCredential(cred);
                    // print(user.user?.displayName);
                    Get.to(const HomeSrc(), transition: Transition.zoom);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        SizedBox(
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(19),
                            //   color: Colors.black12,
                            // ),
                            height: 40,
                            width: 250,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  fillColor: Colors.black12,
                                  filled: true,
                                  hintText: "Email Address",
                                  hintStyle: const TextStyle(
                                    fontFamily: "Encode",
                                    color: Colors.black87,
                                    // fontWeight: FontWeight.w600
                                  ),
                                  contentPadding:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(21))),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  snack_bar("Enter Email", "Oops", context,
                                      ContentType.failure);
                                } else if (value.length < 6) {
                                  snack_bar("Enter valid Email", "Oops",
                                      context, ContentType.failure);
                                }
                                return null;
                              },
                            )),
                        const SizedBox(
                          height: 17,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: Colors.black12,
                            ),
                            height: 40,
                            width: 250,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: const TextStyle(
                                    fontFamily: "Encode",
                                    color: Colors.black87,
                                    // fontWeight: FontWeight.w600
                                  ),
                                  contentPadding:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(21))),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  snack_bar(" Enter Password ", "Oops", context,
                                      ContentType.failure);
                                } else if (value.length < 6) {
                                  snack_bar(
                                      "Password should be grater than 6 elements",
                                      "Oops",
                                      context,
                                      ContentType.failure);
                                }
                                return null;
                              },
                            )),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      // color: Colors.amber,
                      height: 34,
                      width: 250,
                      child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forget Password ?",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Encode",
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      print("object");
                    }
                  },
                  child: Container(
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
                ),
                Image.asset("assets/image/1.png")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
