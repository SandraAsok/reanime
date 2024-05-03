import 'package:flutter/material.dart';
import 'package:reanime/upload/uploads.dart';

class create extends StatefulWidget {
  const create({super.key});

  @override
  State<create> createState() => _createState();
}

class _createState extends State<create> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text(
          'REANIME',
          style: TextStyle(color: Colors.black87, fontSize: 22.5),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 200,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(top: 55),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => uploads(),
                    ));
              },
              icon: Column(
                children: [
                  Icon(
                    Icons.upload,
                    size: 70,
                    color: Colors.orangeAccent,
                  ),
                  Text(
                    'Upload',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
