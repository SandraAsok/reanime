import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reanime/anime/readmanga.dart';
import 'package:url_launcher/url_launcher.dart';

class op extends StatefulWidget {
  final image;
  final title;
  final detail;
  final anime;

  const op(
      {super.key,
      required this.image,
      required this.title,
      required this.anime,
      required this.detail});

  @override
  State<op> createState() => _opState();
}

class _opState extends State<op> {
  List<String> imageList = [];
  Future addWishlist() async {
    await FirebaseFirestore.instance.collection('wishlist').add({
      'anime': widget.anime,
      'image': widget.image,
      'userid': FirebaseAuth.instance.currentUser!.email,
      'detail': widget.detail,
    });
  }

  bool isWish = false;
  String wishId = '';
  String wishname = "";

  checkWishlist() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('wishlist')
        .where('anime', isEqualTo: widget.anime)
        .where('userid', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    final id = snapshot.docs[0].id;
    final name = snapshot.docs[0]['anime'];
    bool iswish = (name == null);
    setState(() {
      isWish = !iswish;
      wishId = id;
    });
  }

  Future<String?> getYoutubeUrl() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('youtubeid')
          .where('Anime', isEqualTo: widget.anime)
          .get();

      final utubeurl = snapshot.docs[0]['Url'];
      return utubeurl;
    } catch (e) {
      print('Error youtube url can\'t fetch  :::::: $e');
    }
    return null;
  }

  Future openYoutube(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    checkWishlist();
  }

  @override
  Widget build(BuildContext context) {
    // final anime_stream = FirebaseFirestore.instance.collection('cast').where('anime',isEqualTo: widget.anime).snapshots();
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text(
          'REANIME',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? youtubeUrl = await getYoutubeUrl();
          if (youtubeUrl != null) {
            openYoutube(youtubeUrl);
          } else {
            print("Youtube Url not found");
          }
        },
        child: Icon(Icons.play_arrow_sharp),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(1.0),
                child: Container(
                  height: 500,
                  width: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.image),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                width: 150,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      var pdfSnapshot = await FirebaseFirestore.instance
                          .collection('pdf_metadata')
                          .where('name', isEqualTo: '${widget.anime}.pdf')
                          .get();
                      if (pdfSnapshot.docs.isNotEmpty) {
                        var pdfUrl = pdfSnapshot.docs.first.data()['url'];
                        print(pdfUrl);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReadManga(pdfUrl: pdfUrl),
                            ));
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("ERROR"),
                              content: Text("Pdf not found"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"))
                              ],
                            );
                          },
                        );
                      }
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("ERROR"),
                            content: Text("Pdf not found"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK"))
                            ],
                          );
                        },
                      );
                      print("Error fetching pdf url: $e");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text(
                    'Read Manga',
                    style: TextStyle(color: Colors.black87, fontSize: 17),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isWish = !isWish;
                        });
                        if (isWish == false) {
                          setState(() {
                            FirebaseFirestore.instance
                                .collection('wishlist')
                                .doc(wishId)
                                .delete();
                          });
                        } else {
                          addWishlist();
                        }
                      },
                      icon: Icon(
                        isWish ? Icons.favorite : Icons.favorite_border,
                        color: isWish ? Colors.red : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ExpansionTile(
              title: Text(
                'Main Characters',
                style: TextStyle(color: Colors.white, fontSize: 23),
              ),
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('cast')
                        .where('anime', isEqualTo: widget.anime)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        print('Error: ${snapshot.error}');
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Text(
                          'No data available',
                          style: TextStyle(color: Colors.white),
                        );
                      }

                      final data = snapshot.data!.docs[0];
                      final List image = data['image'];

                      return Container(
                        height: MediaQuery.of(context).size.height / 2,
                        child: GridView.builder(
                          itemCount: image.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.orangeAccent)),
                                child: Image.network(image[index],
                                    fit: BoxFit.fill),
                              ),
                            );
                          },
                        ),
                      );
                    }),
              ],
            ),
            ExpansionTile(
              title: Text(
                widget.title,
                style: TextStyle(color: Colors.white, fontSize: 23),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.detail,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
