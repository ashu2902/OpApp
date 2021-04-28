import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection("Images").snapshots(),
          builder: (context, snapshot) {
            return snapshot.hasError
                ? Center(
                    child: Text("There is some problem loading your images"),
                  )
                : snapshot.hasData
                    ? GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1,
                        children: snapshot.data.docs
                            .map((e) => Image.network(e.get("url")))
                            .toList(),
                      )
                    : Container();
          },
        ),
      ),
    );
  }
}
