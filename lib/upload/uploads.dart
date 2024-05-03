import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class uploads extends StatefulWidget {
  const uploads({super.key});

  @override
  State<uploads> createState() => _uploadsState();
}

List<String> imageList = [];
List<String> castList = [];

class _uploadsState extends State<uploads> {
  TextEditingController _anime = TextEditingController();
  TextEditingController _url = TextEditingController();
  TextEditingController _detail = TextEditingController();
  String pdfurl = '';

  @override
  Widget build(BuildContext context) {
    Future addAll() async {
      await FirebaseFirestore.instance.collection('allsearch').add({
        'anime': _anime.text,
        'url': _url.text,
        'pdfurl': pdfurl,
        'image': imageList,
        'detail': _detail.text,
      });
    }

    addCast() async{
      FirebaseFirestore.instance.collection('cast').add({
        'anime': _anime.text,
        'image': castList,
      });
    }
    Future<void> uploadPDF(File pdfFile) async {
      try {
        String fileName = basename(pdfFile.path);
        Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child('pdfs/$fileName');
        UploadTask uploadTask = firebaseStorageRef.putFile(pdfFile);
        TaskSnapshot snapshot =
            await uploadTask.whenComplete(() => print('file upload'));
        String downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          pdfurl = downloadUrl;
        });
        // Store metadata in Firestore
        await FirebaseFirestore.instance.collection('pdf_metadata').add({
          'name': fileName,
          'url': downloadUrl,
          'timestamp': DateTime.now(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF uploaded successfully!')),
        );
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading PDF: $e')),
        );
      }
    }

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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _anime,
                decoration: InputDecoration(
                    labelText: 'ANIME',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.orangeAccent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent))),
                style: TextStyle(color: Colors.white),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(1.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orangeAccent)),
                    child: IconButton(
                      onPressed: () async {
                        try {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf'],
                          );
                          if (result != null) {
                            File pdfFile = File(result.files.single.path!);
                            await uploadPDF(pdfFile);
                            setState(() {});
                          } else {
                            // User canceled the picker
                          }
                        } catch (e) {
                          print("ERROR ::::: $e");
                        }
                      },
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Upload File',
                  style: TextStyle(color: Colors.orangeAccent),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  final pickedfile =
                      await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (pickedfile == null) {
                    return;
                  } else {
                    File file = File(pickedfile.path);
                    setState(() async {
                      imageList = await uploadImage(file);
                    });
                  }
                },
                child: Container(
                  height: 200,
                  width: 180,
                  decoration: BoxDecoration(),
                  child: imageList.isEmpty
                      ? Container(
                          height: 200,
                          width: 180,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange)),
                          child: Icon(
                            Icons.add_circle_outline,
                            color: Colors.black87,
                          ),
                        )
                      : Image.network(imageList[0]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Cast',
                  style: TextStyle(color: Colors.orangeAccent),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  final pickedfile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (pickedfile == null) {
                    return;
                  } else {
                    File file = File(pickedfile.path);
                    setState(() async {
                      castList = await uploadCastImage(file);
                    });
                  }
                },
                child: Container(
                  height: 200,
                  width: 180,
                  decoration: BoxDecoration(),
                  child: castList.isEmpty
                      ? Container(
                    height: 200,
                    width: 180,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange)),
                    child: Icon(
                      Icons.add_circle_outline,
                      color: Colors.black87,
                    ),
                  )
                      : Image.network(castList[0]),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _url,
                decoration: InputDecoration(
                    labelText: 'URL',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.orangeAccent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent))),
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _detail,
                decoration: InputDecoration(
                    labelText: 'DETAILS',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.orangeAccent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent))),
                style: TextStyle(color: Colors.white),
              ),
            ),
            Center(
              child:  Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                     addAll();
                     addCast();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                    ),
                    child: Text(
                      'Upload',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ),
              ),
              ),
          ],
        ),
      ),
    );
  }

  Future<List<String>> uploadImage(File file) async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    DateTime now = DateTime.now();
    String timestamp = now.millisecondsSinceEpoch.toString();
    firebase_storage.Reference ref = storage.ref().child('images/$timestamp');
    firebase_storage.UploadTask task = ref.putFile(file);
    await task;
    String downloadURL = await ref.getDownloadURL();
    imageList.add(downloadURL);
    return imageList;
  }

  Future<List<String>> uploadCastImage(File file) async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    DateTime now = DateTime.now();
    String timestamp = now.millisecondsSinceEpoch.toString();
    firebase_storage.Reference ref = storage.ref().child('images/$timestamp');
    firebase_storage.UploadTask task = ref.putFile(file);
    await task;
    String downloadURL = await ref.getDownloadURL();
    castList.add(downloadURL);
    return castList;
  }
}
