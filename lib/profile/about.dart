import 'package:flutter/material.dart';

class about extends StatefulWidget {
  const about({super.key});

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About REANIME',style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.orangeAccent,
      ),
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('lib/asset/re.png')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 200),
              child: Text('About Reanime :-',style: TextStyle(color: Colors.orangeAccent,fontSize: 15),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Reanime is an Manga reading Platform. You can upload and publish your manga in Reanime Android application without any charges. Same way you can read any Manga\'s in here and you can watch the latest trailer of the Anime.',
              style: TextStyle(color: Colors.orangeAccent,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 180),
              child: Text('How to join Reanime?',style: TextStyle(color: Colors.orangeAccent,fontSize: 15),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('If you are a Reader: You can just sign-up on Reanime android application and enjoy reading an endless pool of awesome Manga\'s without any charges.',
                style: TextStyle(color: Colors.orangeAccent,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('If you are an Author: You can sign-up on Reanime android application and start self publishing from the UPLOAD icon available on the Create page. We will make sure your published contents reach lakhs of readers everyday.',
                style: TextStyle(color: Colors.orangeAccent,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
