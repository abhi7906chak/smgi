// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smgi/pages/after_loginOrsignUp/Verify%20Email/verify_email.dart';
import 'package:smgi/pages/after_loginOrsignUp/home_src.dart';
import 'package:smgi/utiles/snack_bar.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final _formkey = GlobalKey<FormState>();
  final passwordcon = TextEditingController();
  final repasswordcon = TextEditingController();
  final namecon = TextEditingController();
  final emailcon = TextEditingController();
  final auth = FirebaseAuth.instance;
  // late bool userVerifed;
  String nameError = "";
  String emailError = "";
  String passError = "";
  String epassError = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                  height: 20,
                ),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        SizedBox(
                            height: 40,
                            width: 250,
                            child: TextFormField(
                              controller: namecon,
                              decoration: InputDecoration(
                                  errorText:
                                      nameError.isNotEmpty ? nameError : null,
                                  fillColor: Colors.black12,
                                  filled: true,
                                  hintText: "Full Name",
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
                                  return;
                                } else if (value.length < 5) {
                                  return;
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
                              controller: emailcon,
                              decoration: InputDecoration(
                                  hintText: "Email Address",
                                  errorText:
                                      emailError.isNotEmpty ? emailError : null,
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
                                  return;
                                } else if (value.length < 6) {
                                  return;
                                }
                                return null;
                              },
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: Colors.black12,
                            ),
                            height: 40,
                            width: 250,
                            child: TextFormField(
                              controller: passwordcon,
                              onChanged: (value) {
                                passwordcon.text = value;
                              },
                              decoration: InputDecoration(
                                  errorText:
                                      passError.isNotEmpty ? passError : null,
                                  hintText: "Create Password",
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
                                  return;
                                } else if (value.length < 6) {
                                  return;
                                }
                                return null;
                              },
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: Colors.black12,
                            ),
                            height: 40,
                            width: 250,
                            child: TextFormField(
                              controller: repasswordcon,
                              onChanged: (value) {
                                repasswordcon.text = value;
                              },
                              decoration: InputDecoration(
                                  errorText:
                                      epassError.isNotEmpty ? epassError : null,
                                  hintText: "Re enter Password",
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
                                  return;
                                } else if (passwordcon.text !=
                                    repasswordcon.text) {
                                  return;
                                }
                                return null;
                              },
                            )),
                      ],
                    )),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    try {
                      if (namecon.text.isEmpty ||
                          emailcon.text.isEmpty ||
                          passwordcon.text.isEmpty ||
                          repasswordcon.text.isEmpty) {
                        // NotValitedMsg();
                        emptyMsg();
                      } else if (namecon.text.length < 6 ||
                          emailcon.text.length < 6 ||
                          passwordcon.text.length < 6 ||
                          repasswordcon.text.length < 6) {
                        lengthCheckMsg();
                      } else if (passwordcon.text != repasswordcon.text) {
                        matchPassMsg();
                      } else {
                        UserCredential usercred =
                            await auth.createUserWithEmailAndPassword(
                                email: emailcon.text,
                                password: passwordcon.text);
                        await usercred.user!.sendEmailVerification();
                        
                        succesMsg();
                        Get.to(() =>  const VerifyEmailSrc(),
                            transition: Transition.zoom);
                      }
                    } catch (e) {
                      firebaseError(e);
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
                      "Sign up",
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
                Image.asset(
                  "assets/image/2.png",
                  // fit: BoxFit.fill,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void succesMsg() {
    snack_bar(
        "Yeah !", "You Sing Up Successfull", context, ContentType.success);
  }

  void emptyMsg() {
    snack_bar("Oops", "All Filed Must Be Filled", context, ContentType.failure);
  }

  void lengthCheckMsg() {
    snack_bar("Check Length", "All Filed Must Have Longer Than 6", context,
        ContentType.warning);
  }

  void matchPassMsg() {
    snack_bar(
        "Check Password", "It Should Be Same", context, ContentType.warning);
  }

  void firebaseError(Object e) {
    if (e is FirebaseAuthException) {
      snack_bar("Error!", e.message.toString(), context, ContentType.failure);
    }
  }
}