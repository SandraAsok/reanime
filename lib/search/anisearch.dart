import 'package:flutter/material.dart';

class anisearch extends StatefulWidget {
  const anisearch({super.key});

  @override
  State<anisearch> createState() => _anisearchState();
}

class _anisearchState extends State<anisearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text('REANIME',style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}
