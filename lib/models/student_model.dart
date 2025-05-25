// models/student_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: camel_case_types
class student {
  final String name;
  final String uid;
  final String photourl;
  final String email;
  final String password1;
  final String? phonenum;
  final String? rollnum;
  final String? aadharnum;
  final String? fathername;
  final String? mothername;
  final String? abcid;
  final String? status;
  // final Map<String, int>? datesheet; // Use String keys
  final DateTime? date;

  student({
    this.phonenum,
    this.rollnum,
    this.aadharnum,
    this.fathername,
    this.mothername,
    this.abcid,
    this.date,
    required this.status,
    // this.datesheet,
    required this.password1,
    required this.name,
    required this.uid,
    required this.photourl,
    required this.email,
  });

  static student fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return student(
      phonenum: snapshot["phonenum"],
      rollnum: snapshot["rollnum"],
      aadharnum: snapshot["aadharnum"],
      fathername: snapshot["fathername"],
      mothername: snapshot["mothername"],
      abcid: snapshot["abcid"],
      // datesheet: snapshot['datesheet'],
      status: snapshot["status"],
      name: snapshot["name"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      password1: snapshot['password1'],
      photourl: snapshot['photourl'],
    );
  }

  Map<String, dynamic> toJson() => {
        // "datesheet": datesheet,
        "status": status,
        "name": name,
        "uid": uid,
        "email": email,
        "photourl": photourl,
        "password1": password1,
      };
}
