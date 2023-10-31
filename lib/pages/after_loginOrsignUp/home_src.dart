import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeSrc extends StatefulWidget {
  const HomeSrc({Key? key});

  @override
  State<HomeSrc> createState() => _HomeSrcState();
}

class _HomeSrcState extends State<HomeSrc> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance
      .reference()
      .child("calendar"); // Corrected the key
  final year = DateTime.now();

  List<DateTime> selectedDays = []; // To store selected days

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          maxRadius: 30,
                          child: Text("image "),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("User Name"),
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
                            colors: [Color(0xFF161697), Color(0xFF9747FF)],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Menu",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Encode",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  "Attendance",
                  style: TextStyle(
                    fontFamily: "Encode",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: ref.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return CircularProgressIndicator();
                    } else {
                      DataSnapshot dataSnapshot = snapshot.data!.snapshot;
                      Map<dynamic, dynamic>? map = dataSnapshot.value as Map?;
                      if (map != null) {
                        int lastMonth = map["last month"] ?? 1;
                        int startMonth = map["start month"] ?? 1;
                        debugPrint("Last Month: $lastMonth");
                        debugPrint("Start Month: $startMonth");

                        return TableCalendar(
                          currentDay: DateTime.now(),
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              if (selectedDays.contains(selectedDay)) {
                                selectedDays.remove(selectedDay);
                              } else {
                                selectedDays.add(selectedDay);
                              }
                            });
                          },
                          selectedDayPredicate: (day) {
                            // Customize the selection color (e.g., to blue)
                            return selectedDays.contains(day);
                          },
                          focusedDay: DateTime(year.year, startMonth, 1),
                          firstDay: DateTime(year.year, startMonth, 1),
                          lastDay: DateTime(year.year, lastMonth, 31),
                          calendarFormat: CalendarFormat.month,
                        );
                      } else {
                        return Text("No data available");
                      }
                    }
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.set({
                    "start month": 10,
                    "last month": 13,
                  });
                },
                child: const Text("Set Data"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
