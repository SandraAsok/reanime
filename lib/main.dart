import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reanime/profile/profile.dart';
import 'package:reanime/upload/create.dart';
import 'package:reanime/home/homepage.dart';
import 'package:reanime/authentication/signup.dart';
import 'package:reanime/search/search.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyCa_UDj0Lj4GISblVoCBF9JyDIp3cUbTKQ",
    appId: "1:322610542475:android:ad3b74eedeb0adb72ae18e",
    messagingSenderId: '322610542475',
    projectId: "reanime-37a9e",
    storageBucket: "reanime-37a9e.appspot.com",
  ));
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: jojo(),
  ));
}

String? finalemail;

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    getValidationData().whenComplete(() async {
      if (finalemail == null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const signup(),
            ));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const bottomnav(),
            ));
      }
    });
    super.initState();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    setState(() {
      finalemail = obtainedEmail!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const bottomnav();
  }
}

class bottomnav extends StatefulWidget {
  const bottomnav({super.key});

  @override
  State<bottomnav> createState() => _bottomnavState();
}

final List<Widget> _pages = [
  const home(),
  const Search(),
  const create(),
  const profile(),
];

class _bottomnavState extends State<bottomnav> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black87,
          backgroundColor: Colors.orangeAccent,
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          selectedLabelStyle: const TextStyle(color: Colors.black87),
          selectedFontSize: 17,
          items: [
            const BottomNavigationBarItem(
              backgroundColor: Colors.orangeAccent,
              icon: Icon(
                Icons.home,
                color: Colors.black87,
              ),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: Colors.black87,
                ),
                label: 'search'),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Colors.black87,
                ),
                label: 'Create'),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outlined,
                  color: Colors.black87,
                ),
                label: 'Profile'),
          ]),
    );
  }
}

class jojo extends StatefulWidget {
  const jojo({super.key});

  @override
  State<jojo> createState() => _jojoState();
}

class _jojoState extends State<jojo> {
  @override
  void initState() {
    super.initState();
    Navigate(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          Container(
            height: 500,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/asset/re.png'),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Read your Manga\'s here',
              style: TextStyle(color: Colors.orangeAccent, fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }

  Navigate(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Splash(),
          ));
    });
  }
}
