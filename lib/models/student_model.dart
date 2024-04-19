import 'package:cloud_firestore/cloud_firestore.dart';

class student {
  final String name;
  final String uid;
  final String photourl;
  final String email;
  final String password;
  final String status;
  // final Map<String, int>? datesheet; // Use String keys
  final DateTime? date;

  student({
    this.date,
    required this.status,
    // this.datesheet,
    required this.password,
    required this.name,
    required this.uid,
    required this.photourl,
    required this.email,
  });

  static student fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return student(
      // datesheet: snapshot['datesheet'],
      status: snapshot["status"],
      name: snapshot["name"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      password: snapshot['password'],
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
      };
}
