import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class HomeSrc extends StatefulWidget {
  const HomeSrc({super.key});

  @override
  State<HomeSrc> createState() => _HomeSrcState();
}

class _HomeSrcState extends State<HomeSrc> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref("calender");
  final year = DateTime.now();
  final firestore = FirebaseFirestore.instance;
  late final String name;
  Map<DateTime, int> datesheet = {};
  bool isLoading = false;
  var userData = {};

  @override
  void initState() {
    super.initState();
    func();
  }

  func() async {
    try {
      setState(() {
        isLoading = true;
      });
      var userdata = await FirebaseFirestore.instance
          .collection("student")
          .doc(auth.currentUser!.uid)
          .get();
      setState(() {
        userData = userdata.data()!;
        // datesheet = userdata['datesheet']; // Handle null data
        if (userData.containsKey('datesheet')) {
          datesheet = Map<DateTime, int>.from(userData['datesheet']);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              body: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                maxRadius: 30,
                                child: Text("image "),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                userData['name'],
                                style: TextStyle(fontFamily: "Encode"),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 40,
                                width: 90,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(19),
                                    gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        colors: [
                                          Color(0xFF161697),
                                          Color(0xFF9747FF),
                                        ])),
                                child: const Center(
                                    child: Text(
                                  "Menu",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Encode"),
                                ))),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Text(
                        "Attendence",
                        style: TextStyle(
                            fontFamily: "Encode",
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder(
                        stream: ref.onValue,
                        builder:
                            (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          } else {
                            Map<dynamic, dynamic> map =
                                snapshot.data!.snapshot.value as dynamic;
                            List<dynamic> data = [];
                            data.clear();
                            data = map.values.toList();
                            int lastMonth;
                            int startMonth;
                            // String startMoonth;
                            try {
                              lastMonth =
                                  int.parse(data[0]["last month"].toString());
                              startMonth =
                                  int.parse(data[0]["start month"].toString());
                              debugPrint("Last Month: $lastMonth");
                              debugPrint("Start Month: $startMonth");
                            } catch (e) {
                              debugPrint(e.toString());
                              lastMonth = 0;
                              startMonth = 0;
                              // startMoonth = "";
                              debugPrint(
                                  "Error occurred while parsing values.");
                            }
                            return Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: HeatMap(
                                  datasets: datesheet,
                                  colorTipCount: 0,
                                  // colorTipHelper: [
                                  //   Text("apsent"),
                                  //   Text("pregent"),
                                  //   // Text("data")
                                  // ],
                                  colorTipSize: 0,
                                  // defaultColor: Colors.blue,
                                  showColorTip: true,
                                  borderRadius: 9,
                                  scrollable: true,
                                  showText: true,
                                  textColor: Colors.black,
                                  size: 30,
                                  colorMode: ColorMode.opacity,
                                  startDate: DateTime(year.year, startMonth, 1),
                                  endDate: DateTime(year.year, lastMonth, 31),
                                  colorsets: {
                                    // if()
                                    1: Colors.green,
                                    4: Colors.red,
                                    2: Colors.purple,
                                    3: Colors.yellow,
                                  }),
                            );
                          }
                        },
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          // final date = DateTime(year.year, 11, 6);
                          await firestore
                              .collection("student")
                              .doc(auth.currentUser!.uid)
                              .update({
                            "datesheet": {
                              DateTime(year.year, 11, 6).toString(): 7,
                              DateTime(year.year, 11, 7).toString(): 7,
                            }
                          }).then((value) => debugPrint("check"));
                        },
                        child: const Text("data")),
                  ],
                ),
              ),
            ),
    );
  }
}
