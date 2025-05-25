// utiles/subjects.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubjectsCard extends StatelessWidget {
  final String teacherEmail;

  const SubjectsCard({super.key, required this.teacherEmail});

  @override
  Widget build(BuildContext context) {
    final docRef =
        FirebaseFirestore.instance.collection('Teacher').doc(teacherEmail);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10.0, left: 30.0),
          child: Text(
            "Subjects",
            style: TextStyle(
              fontFamily: "Encode",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 8),
        FutureBuilder<DocumentSnapshot>(
          future: docRef.get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text("No subjects found"),
              );
            }

            final data = snapshot.data!.data() as Map<String, dynamic>?;

            final List<dynamic>? subjects = data?['subjects'];

            if (subjects == null || subjects.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text("No subjects assigned"),
              );
            }

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: subjects.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final subject = subjects[index].toString();
                  return Chip(
                    label: Text(subject),
                    backgroundColor: Colors.deepPurple.shade100,
                    labelStyle: const TextStyle(color: Colors.deepPurple),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
