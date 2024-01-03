import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:smgi/temp_atten.dart';

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
  Map<DateTime, int> datelist = {};

  // Map<DateTime, int> datesheet = {};
  // Map<DateTime, int> datesheets = {};
  bool isLoading = false;
  var userData = {};
  Map<String, dynamic> datesheetString = {};
  Future<void> RefreshMethod() async {
    // func();
    // initState();
    try {
      var userdata = await FirebaseFirestore.instance
          .collection("student")
          .doc(auth.currentUser!.uid)
          .get();
      var date = await FirebaseFirestore.instance
          .collection("student")
          .doc(auth.currentUser!.uid)
          .collection('atten')
          .doc(year.year.toString())
          .get();
      setState(() async {
        userData = userdata.data()!;
        Map<String, dynamic> sheet = await date.data()!['datesheets'];
        debugPrint('$sheet');

        datelist.clear(); // Clear existing data
        sheet.forEach((key, value) {
          DateTime dateTime = DateTime.parse(key);
          int intValue = int.parse(value.toString());
          datelist[dateTime] = intValue;
        });
        debugPrint(datelist.runtimeType.toString());
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return Future.delayed(Duration(seconds: 2));
  }

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
      var date = await FirebaseFirestore.instance
          .collection("student")
          .doc(auth.currentUser!.uid)
          .collection('atten')
          .doc(year.year.toString())
          .get();
      setState(() async {
        userData = userdata.data()!;
        Map<String, dynamic> sheet = await date.data()!['datesheets'];
        debugPrint('$sheet');

        sheet.forEach((key, value) {
          DateTime dateTime = DateTime.parse(key);
          int intValue = int.parse(value.toString());
          datelist[dateTime] = intValue;
        });
        debugPrint(datelist.runtimeType.toString());
        // Convert datesheetString to datesheet
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
              body: LiquidPullToRefresh(
                showChildOpacityTransition: false,
                color: Color.fromARGB(255, 100, 100, 237),
                height: MediaQuery.of(context).size.height * 0.3,
                onRefresh: () => RefreshMethod(),
                child: ListView(children: [
                  Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
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
                                      style:
                                          const TextStyle(fontFamily: "Encode"),
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
                                          borderRadius:
                                              BorderRadius.circular(19),
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
                          Column(
                            children: [
                              StreamBuilder(
                                stream: ref.onValue,
                                builder: (context,
                                    AsyncSnapshot<DatabaseEvent> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Container();
                                  } else {
                                    Map<dynamic, dynamic> map = snapshot
                                        .data!.snapshot.value as dynamic;
                                    List<dynamic> data = [];
                                    data.clear();
                                    data = map.values.toList();
                                    int lastMonth;
                                    int startMonth;
                                    // String startMoonth;
                                    try {
                                      lastMonth = int.parse(
                                          data[0]["last month"].toString());
                                      startMonth = int.parse(
                                          data[0]["start month"].toString());
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
                                          margin: const EdgeInsets.all(5),
                                          defaultColor: Colors.white,
                                          datasets: datelist,
                                          colorTipCount: 0,
                                          colorTipSize: 0,
                                          showColorTip: true,
                                          borderRadius: 9,
                                          scrollable: true,
                                          showText: true,
                                          textColor: Colors.black,
                                          size: 30,
                                          colorMode: ColorMode.opacity,
                                          startDate: DateTime(
                                              year.year, startMonth, 1),
                                          endDate: DateTime(
                                              year.year, lastMonth, 31),
                                          colorsets: const {
                                            1: Colors.green,
                                            2: Colors.red,
                                            20: Colors.purple,
                                            19: Colors.yellow,
                                          }),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                Get.to(() => TempAtten(
                                      datesheet: datelist,
                                    ));
                              },
                              child: const Text("data")),
                          const Padding(
                            padding: EdgeInsets.all(30.0),
                            child: Text(
                              "Subjects",
                              style: TextStyle(
                                  fontFamily: "Encode",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
    );
  }
}
