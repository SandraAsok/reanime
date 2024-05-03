import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reanime/anime/readhome.dart';

List available = [];
List filtered = [];

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text(
          'REANIME',
          style: TextStyle(color: Colors.black87, fontSize: 22.5),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Search',
                  labelStyle: TextStyle(color: Colors.white),
                  suffixIcon: Icon(
                    Icons.library_books_outlined,
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
              onChanged: filterManga,
            ),
          ),
          Expanded(
              child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('allsearch').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print("ERROR ::: ${snapshot.error}");
              } else if (snapshot.hasData) {
                available = snapshot.data!.docs;
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: filtered.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final DocumentSnapshot snap = filtered[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => readhome(
                                    image: snap['image'][0],
                                    title: 'about ${snap['anime']}',
                                    anime: snap['anime'],
                                    detail: snap['detail']),
                              ));
                        },
                        child: Container(
                          child: Image.network(snap['image'][0]),
                        ),
                      ),
                    );
                  },
                );
              }
              return const CircularProgressIndicator();
            },
          ))
        ],
      ),
    );
  }

  filterManga(String query) {
    setState(() {
      filtered = available.where((doc) {
        String manga = doc.data()['anime'].toLowerCase();
        String searchLower = query.toLowerCase();
        return manga.contains(searchLower);
      }).toList();
    });
  }
}
