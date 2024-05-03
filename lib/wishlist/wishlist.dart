import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../anime/onepiece.dart';

class wishlist extends StatefulWidget {
  const wishlist({super.key});

  @override
  State<wishlist> createState() => _wishlistState();
}

class _wishlistState extends State<wishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text(
          'REANIME',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('wishlist')
              .where('userid',
                  isEqualTo: FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot document = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => op(
                                    anime: document['anime'],
                                    image: document['image'],
                                    title: "About ${document['anime']}",
                                    detail: document['detail'],
                                  )));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                          height: 600,
                          width: 300,
                          child: Image.asset(document['image'])),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
