import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PhotoGallery extends StatefulWidget {
  @override
  _PhotoGalleryState createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    String eventID;
    String eventName;
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      resizeToAvoidBottomInset: true,
      body: StreamBuilder(
        stream: _firebaseFirestore.collection('Gallery').snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasError
              ? Container(
                  child: Text('error'),
                )
              : snapshot.hasData
                  ? Center(
                      child: Container(
                        height: _height,
                        width: _width / 1.25,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            height: _height / 1.35,
                            child: ListView.builder(
                              shrinkWrap: true,
                              clipBehavior: Clip.hardEdge,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                var doc = snapshot.data.docs[index].data();
                                var img = snapshot.data.docs[index].data();
                                var id = snapshot.data.docs[index].id;
                                var name = snapshot.data.docs[index].data();

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      eventID = id;
                                      eventName = name['title'];
                                      print(eventID);
                                      print(eventName);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EventPage(
                                                    eventID: eventID,
                                                    eventName: eventName,
                                                  )));
                                    },
                                    child: Container(
                                      height: _height / 6,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 8,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: _width,
                                          child: ListTile(
                                            title: Center(
                                              child: Text(
                                                doc["title"],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        value: 5,
                        semanticsLabel: 'Loading',
                      ),
                    );
        },
      ),
    );
  }
}

class EventPage extends StatefulWidget {
  final String eventID;
  final String eventName;
  EventPage({@required this.eventID, this.eventName});

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.eventName}'),
        ),
        body: StreamBuilder(
            stream: _firebaseFirestore
                .collection('Gallery')
                .doc(widget.eventID)
                .collection('photo')
                .snapshots(),
            builder: (context, snapshot) {
              return snapshot.hasError
                  ? Container(
                      child: Center(child: Text('${snapshot.error}')),
                    )
                  : snapshot.hasData
                      ? Container(
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                var img = snapshot.data.docs[index].data();
                                return Container(
                                  child:
                                      Center(child: Image.network(img['url'])),
                                );
                              }),
                        )
                      : Container(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator());
            }));
  }
}
