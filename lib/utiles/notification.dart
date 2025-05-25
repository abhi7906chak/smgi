// utiles/notification.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();

  static String _formatDate(dynamic timestamp) {
    if (timestamp is Timestamp) {
      final dt = timestamp.toDate();
      return "${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute}";
    }
    return "Unknown";
  }
}

class _PostListScreenState extends State<PostListScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final currentEmail = auth.currentUser?.email;
    print("📧 Current Email: $currentEmail");

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Posts"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: currentEmail == null
          ? const Center(child: Text("User not logged in"))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Teacher')
                  .doc("abhi1@gmail.com")
                  .collection("Post")
                  // .orderBy('date', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final docs = snapshot.data!.docs;
                  print("📄 Documents Count: ${docs.length}");
                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      var d = docs[index].data() as Map<String, dynamic>;
                      print("📄 Document Data: $d");
                      // final data = posts[index].data() as Map<String, dynamic>;

                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16)),
                              child: Image.network(
                                d['photoUrl'] ??
                                    'https://via.placeholder.com/400x200.png?text=No+Image',
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  height: 200,
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.image_not_supported,
                                      size: 50),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    d['title'] ?? 'No Title',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Likes: ${d['like'] ?? 0}",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Posted on: ${PostListScreen._formatDate(d['date'])}",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }
}
