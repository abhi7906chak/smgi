// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'dart:io';
import 'dart:ui';

// import 'package:firebase_storage/firebase_storage.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smgi/utiles/snack_bar.dart';
import 'package:smgi/utiles/user_profile_post_button.dart';

class IconUserProfile extends StatefulWidget {
  const IconUserProfile({super.key});

  @override
  State<IconUserProfile> createState() => _IconUserProfileState();
}

class _IconUserProfileState extends State<IconUserProfile> {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final phonecon = TextEditingController();
  final rollcon = TextEditingController();
  final aadharcon = TextEditingController();
  final fathercon = TextEditingController();
  final mothercon = TextEditingController();
  final abccon = TextEditingController();

  var userdata;
  @override
  void initState() {
    super.initState();
    getData();
  }

  final ImagePicker picker = ImagePicker();
  File? image;
  String ImageUrl = "";
  Future<void> getImage(ImageSource source) async {
    final XFile? pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        if (kDebugMode) {
          print("aa gyi" + image.toString());
        }
      } else {
        if (kDebugMode) {
          print("user exit the program");
        }
      }
    });
  }

  Future<void> getData() async {
    var UserData = await firestore
        .collection("student")
        .doc(auth.currentUser!.email)
        .get();
    setState(() {
      userdata = UserData.data()!;
    });
  }

  void postbutton() async {
    String? imageUrl = await postButton()
        .uploadProfile(image!, auth.currentUser!.email.toString());
    if (imageUrl != null) {
      ImageUrl = imageUrl;
      await FirebaseFirestore.instance
          .collection("student")
          .doc(auth.currentUser!.email)
          .update({"photourl": ImageUrl.toString()});
    } else {
      ImageUrl = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userdata == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
              // height: double.infinity,
              // width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(userdata["photourl"]),
                      fit: BoxFit.cover)),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                    // height: 200,
                    // width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(userdata["photourl"]),
                                      fit: BoxFit.cover)),
                            ),
                            Positioned(
                                bottom: 10,
                                right: 10,
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Select any one of them"),
                                          actionsAlignment:
                                              MainAxisAlignment.start,
                                          actions: [
                                            Column(
                                              children: [
                                                TextButton(
                                                    onPressed: () async {
                                                      await getImage(ImageSource
                                                              .gallery)
                                                          .then(
                                                        (value) {
                                                          postbutton();
                                                          Get.back();
                                                        },
                                                      );

                                                      // postbutton();
                                                    },
                                                    child:
                                                        const Text("Gallery")),
                                                TextButton(
                                                    onPressed: () {
                                                      getImage(ImageSource
                                                              .camera)
                                                          .then(
                                                        (value) {
                                                          Get.back();
                                                          postbutton();
                                                        },
                                                      );
                                                    },
                                                    child:
                                                        const Text("Camera")),
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 30,
                                  ),
                                )),
                            const Positioned(
                                bottom: 34,
                                right: 4,
                                child: Icon(
                                  Icons.add,
                                  size: 20,
                                )),
                          ],
                        ),
                        Text(
                          userdata["name"],
                          style: const TextStyle(
                              fontFamily: "Encode",
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          userdata["email"],
                          style: const TextStyle(
                              fontFamily: "Encode",
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        Flexible(
                          flex: 3,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: TextField(
                                    controller: phonecon,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: "Phone Number",
                                      hintStyle:
                                          const TextStyle(color: Colors.black),
                                      icon: const Icon(Icons.phone,
                                          color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 19, 5, 211)),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10),
                                  child: TextField(
                                    controller: rollcon,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: "Roll Number",
                                      hintStyle:
                                          const TextStyle(color: Colors.black),
                                      helperText: "CSJMU Roll no.",
                                      helperStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      icon: const Icon(Icons.numbers,
                                          color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 19, 5, 211)),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10),
                                  child: TextField(
                                    controller: aadharcon,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: "Aadhar Card Number",
                                      hintStyle:
                                          const TextStyle(color: Colors.black),
                                      // helperText: "CSJMU Roll no.",
                                      helperStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      icon: const Icon(Icons.card_membership,
                                          color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 19, 5, 211)),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10),
                                  child: TextField(
                                    controller: fathercon,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: "Father Name",
                                      hintStyle:
                                          const TextStyle(color: Colors.black),
                                      // helperText: "CSJMU Roll no.",
                                      helperStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      icon: const Icon(Icons.person,
                                          color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 19, 5, 211)),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10),
                                  child: TextField(
                                    controller: mothercon,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: "Mother Name",
                                      hintStyle:
                                          const TextStyle(color: Colors.black),
                                      // helperText: "CSJMU Roll no.",
                                      helperStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      icon: const Icon(Icons.person_2_outlined,
                                          color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 19, 5, 211)),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10),
                                  child: TextField(
                                    controller: abccon,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: "ABC Id",
                                      hintStyle:
                                          const TextStyle(color: Colors.black),
                                      // helperText: "CSJMU Roll no.",
                                      helperStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      icon: const Icon(
                                          Icons.assignment_ind_sharp,
                                          color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 19, 5, 211)),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        await firestore
                                            .collection("student")
                                            .doc(auth.currentUser!.email)
                                            .update({
                                          "phonenum": phonecon.text,
                                          "rollnum": rollcon.text,
                                          "aadharnum": aadharcon.text,
                                          "fathername": fathercon.text,
                                          "mothername": mothercon.text,
                                          "abcid": abccon.text,
                                        }).then(
                                          (value) {
                                            snack_bar(
                                                "Done !!",
                                                "Details Saved",
                                                context,
                                                ContentType.success);
                                          },
                                        );
                                      } catch (e) {
                                        snack_bar(
                                            "Something Went Wrong",
                                            "Try againg or after some time",
                                            context,
                                            ContentType.failure);
                                      }
                                    },
                                    child: const Text("Approve")),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
