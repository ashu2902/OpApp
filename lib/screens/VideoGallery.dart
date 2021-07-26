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
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xffff6b5c),
          title: Text(
            'Video Gallery',
            textAlign: TextAlign.center,
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
                                    physics: BouncingScrollPhysics(),
                                    itemCount: snapshot.data.docs.length,
                                    itemExtent: _height / 2.9,
                                    itemBuilder: (context, index) {
                                      var doc = snapshot.data.docs[index];
                                      var img = snapshot.data.docs[index];
                                      return snapshot.hasData
                                          ? Container(
                                              child: Card(
                                                elevation: 3,
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
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: Container(
                                                          height: _height / 4,
                                                          child: Image.network(
                                                            img["img"],
                                                            loadingBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    Widget
                                                                        child,
                                                                    ImageChunkEvent
                                                                        loadingProgress) {
                                                              return loadingProgress ==
                                                                      null
                                                                  ? child
                                                                  : Center(
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                      value: loadingProgress.expectedTotalBytes !=
                                                                              null
                                                                          ? loadingProgress.cumulativeBytesLoaded /
                                                                              loadingProgress.expectedTotalBytes
                                                                          : null,
                                                                    ));
                                                            },
                                                            height: _height,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                        'Name: ${doc['title']}'),
                                                    Text('Date:${doc['date']} ')
                                                  ],
                                                ),
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
