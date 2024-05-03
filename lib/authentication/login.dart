// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reanime/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  login() async {
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Login successful",
            style: TextStyle(color: Colors.black87),
          ),
          action: SnackBarAction(
            onPressed: () {},
            label: 'Dismiss',
            textColor: Colors.black87,
          ),
        ));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => bottomnav(),
            ));
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.orangeAccent,
        content: Text("Incorrect email or password",
            style: TextStyle(color: Colors.black87)),
        action: SnackBarAction(
          onPressed: () {
            Navigator.pop(context);
          },
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'REANIME',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/asset/re.png'),
                ),
              ),
            ),
            Text(
              'Welcome back',
              style: TextStyle(color: Colors.orangeAccent, fontSize: 30.0),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Email or Username',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    labelText: 'Enter Email',
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
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
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
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                width: 150,
                child: ElevatedButton(
                  onPressed: () async {
                    final SharedPreferences sharedpreferences =
                        await SharedPreferences.getInstance();
                    sharedpreferences.setString('email', email.text);
                    login();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
