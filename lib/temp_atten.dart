import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TempAtten extends StatefulWidget {
  final Map<DateTime, int> datesheet;
  const TempAtten({super.key, required this.datesheet});

  @override
  State<TempAtten> createState() => TempAttenState();
}

class TempAttenState extends State<TempAtten> {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final year = DateTime.now();
  var slecteddate = DateTime.now();
  DateTime? picked;

  slecttime() async {
    picked = await showDatePicker(
      context: context,
      initialDate: slecteddate,
      firstDate: DateTime(year.year, 10, 1),
      lastDate: DateTime(year.year, 12, 31),
    );
    if (picked != null) {
      // Handle the picked date
      setState(() {
        slecteddate = picked!;
        // Update the state with the picked date if needed
      });
      debugPrint('$picked');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: StreamBuilder(
              stream: firestore.collection('student').snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var studentData = snapshot.data!.docs[index].data();
                    return ListTile(
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () async {
                              Map<String, int> datesheetData = {
                                picked!.toIso8601String(): 5,
                                // DateTime(year.year, 11, 3).toIso8601String(): 7,
                                // DateTime(year.year, 11, 4).toIso8601String(): 7,
                                // DateTime(year.year, 11, 5).toIso8601String(): 7
                              };
                              await firestore
                                  .collection("student")
                                  .doc(auth.currentUser!.uid)
                                  .collection("atten")
                                  .doc('1')
                                  .update({"datesheets": datesheetData}).then(
                                      (value) {
                                // Get.to(() => const TempAtten());
                                debugPrint("chekc");
                              });
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: const Icon(Icons.check),
                            onPressed: () {},
                          )
                        ],
                      ),
                      title: Text(studentData['name']),
                      subtitle: Text(studentData['email']),
                    );
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await slecttime();
              if (picked != null) {
                // Get the existing datesheets from Firestore
                DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
                    await firestore
                        .collection("student")
                        .doc(auth.currentUser!.uid)
                        .collection("atten")
                        .doc('1')
                        .get();

                Map<String, dynamic> existingDatesheets =
                    documentSnapshot.data()?['datesheets'] ?? {};

                // Update the existing datesheets with the new entry
                existingDatesheets = {
                  ...existingDatesheets,
                  picked!.toIso8601String(): 5
                };

                // Write the updated datesheets back to Firestore
                await firestore
                    .collection("student")
                    .doc(auth.currentUser!.uid)
                    .collection("atten")
                    .doc('1')
                    .update({"datesheets": existingDatesheets}).then((value) {
                  debugPrint("check");
                });
              }
            },
            child: Text("show date"),
          ),
        ],
      )),
    );
  }
}
