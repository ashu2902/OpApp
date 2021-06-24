import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: Container(
        child: Container(
          child: StreamBuilder(
            stream: _firebaseFirestore.collection('Gallery').snapshots(),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              return snapshot.hasError
                  ? Container(
                      child: Text('error'),
                    )
                  : snapshot.hasData
                      ? Container(
                          color: Colors.white,
                          height: _height,
                          width: _width,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Container(
                                      child: Text(
                                        'Select event',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      height: _height / 1.5,
                                      width: _width / 2,
                                      child: Container(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          clipBehavior: Clip.hardEdge,
                                          itemCount: snapshot.data.docs.length,
                                          itemBuilder: (context, index) {
                                            var doc = snapshot.data.docs[index];

                                            var id =
                                                snapshot.data.docs[index].id;
                                            var name =
                                                snapshot.data.docs[index];

                                            return GestureDetector(
                                              onTap: () {
                                                eventID = id;
                                                eventName = name['title'];
                                                print(eventID);
                                                print(eventName);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EventPage(
                                                      eventID: eventID,
                                                      eventName: eventName,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: _height / 12,
                                                child: Card(
                                                  elevation: 5,
                                                  child: Center(
                                                    child: Text(
                                                      doc["title"],
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontStyle:
                                                              FontStyle.normal),
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
                                ],
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
        ),
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
                      child: Center(
                        child: Text('${snapshot.error}'),
                      ),
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
                                var item = snapshot.data.docs.length;
                                return item == null
                                    ? Container(
                                        child: Center(
                                          child: Text('NO images'),
                                        ),
                                      )
                                    : Container(
                                        child: Center(
                                          child: Image.network(img['url']),
                                        ),
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
