import 'package:cloud_firestore/cloud_firestore.dart';

class student {
  final String name;
  final String uid;
  final String photourl;
  final String email;
  final String password;
  final Map<DateTime, int>? datesheet; // Use String keys
  final DateTime? date;

  student({
    this.date,
    this.datesheet,
    required this.password,
    required this.name,
    required this.uid,
    required this.photourl,
    required this.email,
  });

  factory student.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    Map<String, dynamic>? datesheet = snapshot["datesheet"];
    if (datesheet != null) {
      // Convert keys (String) to DateTime
      Map<DateTime, int> datesheetMap = {};
      datesheet.forEach((key, value) {
        datesheetMap[DateTime.parse(key)] = value;
      });

      return student(
        datesheet: datesheetMap,
        password: snapshot["password"],
        name: snapshot["name"],
        uid: snapshot["uid"],
        email: snapshot["email"],
        photourl: snapshot["photourl"],
        date: snapshot['date'],
      );
    }

    return student(
      datesheet: null,
      password: snapshot["password"],
      name: snapshot["name"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photourl: snapshot["photourl"],
      date: snapshot['date'],
    );
  }

  Map<String, dynamic> toJson() {
    if (datesheet != null) {
      // Convert keys (DateTime) to String
      Map<String, dynamic> datesheetMap = {};
      datesheet!.forEach((key, value) {
        datesheetMap[key.toString()] = value;
      });

      return {
        "datesheet": datesheetMap,
        "name": name,
        "uid": uid,
        "email": email,
        "photoUrl": photourl,
        "password": password,
        "date": date,
      };
    }

    return {
      "name": name,
      "uid": uid,
      "email": email,
      "photoUrl": photourl,
      "password": password,
      "date": date,
    };
  }
}
