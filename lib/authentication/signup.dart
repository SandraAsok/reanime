// ignore_for_file: unnecessary_null_comparison, unused_catch_clause

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reanime/main.dart';
import 'package:reanime/authentication/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

List<String> imageList = [];

class _signupState extends State<signup> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController bio = TextEditingController();

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

  add() async {
    await FirebaseFirestore.instance.collection('profile').add({
      'image': imageList,
      'name': name.text,
      'bio': bio.text,
      'email': email.text,
    });
  }

  signup() async {
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: const Text("Login successful",
              style: TextStyle(color: Colors.black87)),
          action: SnackBarAction(
            onPressed: () {},
            label: 'Dismiss',
            textColor: Colors.black87,
          ),
        ));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const bottomnav(),
            ));
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.orangeAccent,
        content: const Text("Incorrect email or password",
            style: TextStyle(color: Colors.black87)),
        action: SnackBarAction(
          onPressed: () {},
          label: 'Dismiss',
          textColor: Colors.black87,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('lib/asset/re.png')),
                ),
              ),
            ),
            const Text(
              '𝓦𝓮𝓵𝓬𝓸𝓶𝓮',
              style: TextStyle(color: Colors.orangeAccent, fontSize: 30.0),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Create your REANIME account',
                style: TextStyle(color: Colors.orangeAccent),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () async {
                    final pickedfile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
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
                    decoration: const BoxDecoration(),
                    child: imageList.isEmpty
                        ? const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.orangeAccent,
                            child: Icon(
                              Icons.add_circle_outline,
                              color: Colors.black87,
                            ),
                          )
                        : Image.network(imageList[0]),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Name',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: name,
                decoration: const InputDecoration(
                    labelText: 'Enter Name',
                    labelStyle: TextStyle(color: Colors.white),
                    suffixIcon: Icon(
                      Icons.person_outlined,
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.orangeAccent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent))),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Bio',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: bio,
                decoration: const InputDecoration(
                    labelText: 'Enter Bio',
                    labelStyle: TextStyle(color: Colors.white),
                    suffixIcon: Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.orangeAccent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent))),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Email',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: email,
                decoration: const InputDecoration(
                    labelText: 'Enter Email',
                    labelStyle: TextStyle(color: Colors.white),
                    suffixIcon: Icon(
                      Icons.mail_outline,
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.orangeAccent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent))),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Password',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: password,
                decoration: const InputDecoration(
                    labelText: 'Enter Password',
                    labelStyle: TextStyle(color: Colors.white),
                    suffixIcon: Icon(
                      Icons.lock_outline_rounded,
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.orangeAccent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent))),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                width: 150,
                child: ElevatedButton(
                  onPressed: () async {
                    final SharedPreferences sharedpreferences =
                        await SharedPreferences.getInstance();
                    sharedpreferences.setString('email', email.text);
                    signup();
                    add();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 75),
                child: Row(
                  children: [
                    const Text(
                      'Alredy have an account ?',
                      style: TextStyle(color: Colors.white),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const login(),
                            ));
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.orangeAccent),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
