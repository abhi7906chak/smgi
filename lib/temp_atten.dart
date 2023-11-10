import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TempAtten extends StatefulWidget {
  const TempAtten({super.key});

  @override
  State<TempAtten> createState() => TempAttenState();
}

class TempAttenState extends State<TempAtten> {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final year = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: StreamBuilder(
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
                          DateTime(year.year, 11, 2).toIso8601String(): 5,
                          DateTime(year.year, 11, 3).toIso8601String(): 7,
                          DateTime(year.year, 11, 4).toIso8601String(): 7,
                          DateTime(year.year, 11, 5).toIso8601String(): 7
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
      )),
    );
  }
}
