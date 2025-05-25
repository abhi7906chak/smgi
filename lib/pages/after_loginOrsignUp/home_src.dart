// pages/after_loginOrsignUp/home_src.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:smgi/utiles/ai_src.dart';
import 'package:smgi/utiles/comming_soon.dart';
import 'package:smgi/utiles/notification.dart';
import 'package:smgi/utiles/setting.dart';
import 'package:smgi/utiles/social_links.dart';
import 'package:smgi/utiles/subjects.dart';
import 'package:smgi/utiles/support.dart';
import 'package:smgi/utiles/time_table.dart';
import 'package:smgi/utiles/widgets/icon_user_profile.dart';

// import 'package:smgi/temp_atten/.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool isLoading = false;
  String timetablestring = '';
  var userData = {};

  Map<String, dynamic> datesheetString = {};
  // ignore: non_constant_identifier_names
  Future<void> RefreshMethod() async {
    try {
      var userdata = await FirebaseFirestore.instance
          .collection("student")
          .doc(auth.currentUser!.email)
          .get();
      var date = await FirebaseFirestore.instance
          .collection("student")
          .doc(auth.currentUser!.email)
          .collection('atten')
          .doc(year.year.toString())
          .get();
      setState(() {
        userData = userdata.data()!;
        setState(() {});
        Map<String, dynamic> sheet = date.data()!['datesheets'];
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
    return Future.delayed(const Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    func();
    getTimetable();
  }

  Future<void> getTimetable() async {
    try {
      var docSnapshot = await FirebaseFirestore.instance
          .collection("Teacher")
          .doc("abhi1@gmail.com")
          .get();

      if (docSnapshot.exists) {
        var data = docSnapshot.data();
        var timetable = data?['timetable'] as String?;
        print("Fetched timetable: $timetable");

        setState(() {
          timetablestring = timetable ?? "No URL found";
        });
      } else {
        print("Document does not exist");
      }
    } catch (e) {
      print("Error fetching timetable: $e");
    }
  }

  Future<void> func() async {
    try {
      setState(() {
        isLoading = true;
      });

      var userdata = await FirebaseFirestore.instance
          .collection("student")
          .doc(auth.currentUser!.email)
          .get();
      var date = await FirebaseFirestore.instance
          .collection("student")
          .doc(auth.currentUser!.email)
          .collection('atten')
          .doc(year.year.toString())
          .get();
      setState(() {
        userData = userdata.data()!;
        Map<String, dynamic> sheet = date.data()!['datesheets'];
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
              key: _scaffoldKey,
              endDrawer: Drawer(
                child: SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30, left: 20),
                            child: Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              "Hello,  " + userData['name'],
                              style: const TextStyle(
                                fontFamily: "Encode",
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF161697),
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          // indent: 50,
                          endIndent: 50,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            children: [
                              ListTile(
                                leading:
                                    const FaIcon(FontAwesomeIcons.userLarge),
                                title: const Text(
                                  "Profile",
                                  style: TextStyle(
                                    fontFamily: "Encode",
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF161697),
                                  ),
                                ),
                                onTap: () =>
                                    Get.to(() => const IconUserProfile()),
                              ),
                              ListTile(
                                leading:
                                    const FaIcon(FontAwesomeIcons.bookOpen),
                                title: const Text(
                                  "Subjects",
                                  style: TextStyle(
                                    fontFamily: "Encode",
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF161697),
                                  ),
                                ),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const ComingSoonPage(),
                                      transition: Transition.rightToLeft);
                                },
                                child: const ListTile(
                                  leading:
                                      FaIcon(FontAwesomeIcons.bookOpenReader),
                                  title: Text(
                                    "Courses",
                                    style: TextStyle(
                                      fontFamily: "Encode",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF161697),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const PostListScreen(),
                                      transition: Transition.rightToLeft);
                                },
                                child: const ListTile(
                                  leading: FaIcon(FontAwesomeIcons.solidBell),
                                  title: Text(
                                    "Notifications",
                                    style: TextStyle(
                                      fontFamily: "Encode",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF161697),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const ComingSoonPage(),
                                      transition: Transition.rightToLeft);
                                },
                                child: const ListTile(
                                  leading: FaIcon(
                                      FontAwesomeIcons.solidCalendarDays),
                                  title: Text(
                                    "Events",
                                    style: TextStyle(
                                      fontFamily: "Encode",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF161697),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const ComingSoonPage(),
                                      transition: Transition.rightToLeft);
                                },
                                child: const ListTile(
                                  leading: FaIcon(FontAwesomeIcons.dollarSign),
                                  title: Text(
                                    "Fees",
                                    style: TextStyle(
                                      fontFamily: "Encode",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF161697),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const AiSrc(),
                                      transition: Transition.rightToLeft);
                                },
                                child: const ListTile(
                                  leading: FaIcon(FontAwesomeIcons.robot),
                                  title: Text(
                                    "Artificial Intelligence",
                                    style: TextStyle(
                                      fontFamily: "Encode",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF161697),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const StaticSettingsScreen(),
                                      transition: Transition.rightToLeft);
                                },
                                child: const ListTile(
                                  leading: FaIcon(FontAwesomeIcons.gear),
                                  title: Text(
                                    "settings",
                                    style: TextStyle(
                                      fontFamily: "Encode",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF161697),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const CollegeSupportScreen(),
                                      transition: Transition.rightToLeft);
                                },
                                child: const ListTile(
                                  leading:
                                      FaIcon(FontAwesomeIcons.solidLifeRing),
                                  title: Text(
                                    "Support",
                                    style: TextStyle(
                                      fontFamily: "Encode",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF161697),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(
                                      () => const SocialLinksScreen(
                                            facebookUrl:
                                                "https://www.facebook.com/profile.php?id=100022992082245",
                                            instagramUrl:
                                                "https://www.instagram.com/abhishek_khatik_214/",
                                            githubUrl:
                                                "https://github.com/abhi7906chak",
                                            linkedinUrl:
                                                "https://www.linkedin.com/in/abhishek-kumar-chak/",
                                          ),
                                      transition: Transition.rightToLeft);
                                },
                                child: const ListTile(
                                  leading: FaIcon(FontAwesomeIcons.circleInfo),
                                  title: Text(
                                    "About: Developer",
                                    style: TextStyle(
                                      fontFamily: "Encode",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF161697),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              body: LiquidPullToRefresh(
                showChildOpacityTransition: false,
                color: const Color.fromARGB(255, 100, 100, 237),
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
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          // height: 30,
                                          child: CachedNetworkImage(
                                              // fit: BoxFit.cover,
                                              imageBuilder: (context,
                                                      imageProvider) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: imageProvider),
                                                    ),
                                                  ),
                                              // width: 30,
                                              fadeInCurve: Curves.bounceIn,
                                              placeholder: (context, url) =>
                                                  const SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                              imageUrl: userData["photourl"]),
                                        ),
                                      ],
                                      // child:
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      userData['name'],
                                      style: const TextStyle(
                                          fontFamily: "Encode", fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      openDrawer();
                                      if (kDebugMode) {
                                        print("menu");
                                      }
                                    },
                                    child: Container(
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
                                  ),
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
                          // const Padding(
                          //   padding: EdgeInsets.only(top: 10.00, left: 30.00),
                          //   child: Text(
                          //     "Subjects",
                          //     style: TextStyle(
                          //         fontFamily: "Encode",
                          //         fontWeight: FontWeight.bold,
                          //         fontSize: 20),
                          //   ),
                          // ),
                          SubjectsCard(teacherEmail: "abhi1@gmail.com"),
                          TimetableCard(
                            imageUrl: timetablestring ?? "",
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

  void openDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }
}
