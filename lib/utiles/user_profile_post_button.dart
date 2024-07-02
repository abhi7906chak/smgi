// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class postButton {
  final firestore = FirebaseStorage.instance;
  String? ImageUrl;
  final storage = FirebaseFirestore.instance;

  Future<String?> uploadProfile(File image, String location) async {
    try {
      final storageref = firestore.ref().child(location);
      await storageref.putFile(image);

      ImageUrl = await storageref.getDownloadURL();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return ImageUrl;
  }
}
