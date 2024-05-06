import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reanime/profile/about.dart';
import 'package:reanime/authentication/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../anime/onepiece.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _aboutState();
}

class _aboutState extends State<profile> {
  Future Nameedit() async {
    String newname = edit.text;
    await FirebaseFirestore.instance
        .collection('Username')
        .doc('user_id')
        .update({
      'name': newname,
    }).then((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Name Saved Sucessfully')));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to save name: $error'),
      ));
    });
  }

  TextEditingController edit = TextEditingController();

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
      endDrawer: Padding(
        padding: EdgeInsets.all(8.0),
        child: Drawer(
          backgroundColor: Colors.black87,
          child: ListView(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/asset/re.png'),
                  ),
                ),
              ),
              ListTile(
                leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => about(),
                        ));
                  },
                  icon: Icon(
                    Icons.info_outline,
                    color: Colors.orangeAccent,
                  ),
                ),
                title: Text(
                  'About',
                  style: TextStyle(color: Colors.orangeAccent),
                ),
              ),
              ListTile(
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.security,
                    color: Colors.orangeAccent,
                  ),
                ),
                title: Text(
                  'Privacy Policy',
                  style: TextStyle(color: Colors.orangeAccent),
                ),
              ),
              ListTile(
                leading: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: AlertDialog(
                            title: Text('Are you sure?'),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    FirebaseAuth.instance.signOut();
                                    final SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    sharedPreferences.setString('email', '');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => signup(),
                                        ));
                                  },
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.black87),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('No',
                                      style: TextStyle(color: Colors.black87)))
                            ],
                            backgroundColor: Colors.orangeAccent,
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.login,
                    color: Colors.orangeAccent,
                  ),
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(color: Colors.orangeAccent),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('profile')
                .where('email',
                    isEqualTo: FirebaseAuth.instance.currentUser!.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print("ERROR ::: ${snapshot.error}");
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              final user = snapshot.data!.docs[0];
              return Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('lib/asset/re.png')),
                        ),
                      ),
                      Container(
                        height: 500,
                        color: Colors.black87,
                        child: Column(
                          children: [
                            Container(
                              color: Colors.black87,
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 50, left: 10),
                                      child: Text(
                                        user['name'],
                                        style: TextStyle(
                                            color: Colors.orangeAccent,
                                            fontSize: 25.0),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        user['bio'],
                                        style: TextStyle(
                                            color: Colors.orangeAccent,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 250),
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 200,
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('wishlist')
                                      .where('userid',
                                          isEqualTo: FirebaseAuth
                                              .instance.currentUser!.email)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            final DocumentSnapshot document =
                                                snapshot.data!.docs[index];
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            op(
                                                              anime: document[
                                                                  'anime'],
                                                              image: document[
                                                                  'image'],
                                                              title:
                                                                  "About ${document['anime']}",
                                                              detail: document[
                                                                  'detail'],
                                                            )));
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Container(
                                                    height: 200,
                                                    width: 150,
                                                    // color: Colors.white,
                                                    child: Image.asset(
                                                        document['image'])),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      print("ERROR ::: ${snapshot.error}");
                                    }
                                    return CircularProgressIndicator();
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 300, left: 10),
                    child: CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(user['image'][0])),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
