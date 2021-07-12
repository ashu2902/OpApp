import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:opbhallafoundation/widgets/VideoPlayer.dart';

class VideoGallery extends StatefulWidget {
  @override
  _VideoGalleryState createState() => _VideoGalleryState();
}

class _VideoGalleryState extends State<VideoGallery> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            'Video Gallery',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.chevron_left_sharp),
              iconSize: 30,
              color: Colors.black,
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        body: StreamBuilder(
            stream: _firebaseFirestore.collection('VideoGallery').snapshots(),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              return snapshot.hasError
                  ? Container()
                  : snapshot.hasData
                      ? Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: Container(
                              width: _width / 1.2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, index) {
                                      var doc = snapshot.data.docs[index];
                                      var img = snapshot.data.docs[index];
                                      return snapshot.hasData
                                          ? Card(
                                              elevation: 10,
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              VideoPlayerWidget(
                                                            url: doc["url"],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: Image.network(
                                                          img["img"]),
                                                    ),
                                                  ),
                                                  Text('Name: ${doc['title']}'),
                                                  Text('Date:${doc['date']} ')
                                                ],
                                              ),
                                            )
                                          : snapshot.hasError
                                              ? Container()
                                              : Center(
                                                  child:
                                                      CircularProgressIndicator());
                                    }),
                              ),
                            ),
                          ),
                        )
                      : Center(child: CircularProgressIndicator());
            }));
  }
}
