import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smgi/pages/after_loginOrsignUp/home_src.dart';


class Homedata
{
  final firestore = FirebaseFirestore.instance;
  getdata()
  {
    return   StreamBuilder(stream: firestore.collection("student").snapshots(),
     builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      return const HomeSrc();
                
              },);
  }
}