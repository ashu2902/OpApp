import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:opbhallafoundation/screens/WebViewScreens/Events.dart';

class EventRegistration extends StatefulWidget {
  @override
  _EventRegistrationState createState() => _EventRegistrationState();
}

class _EventRegistrationState extends State<EventRegistration> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    String eventID;
    String eventName;
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Registration'),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xffff6b5c),
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        child: Container(
          child: StreamBuilder(
            stream: _firebaseFirestore.collection('OnGoingEvents').snapshots(),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              return snapshot.hasError
                  ? Container(
                      child: Text('error'),
                    )
                  : snapshot.hasData
                      ? Container(
                          color: Colors.grey[100],
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
                                      height: _height / 1.5,
                                      width: _width / 2,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        clipBehavior: Clip.hardEdge,
                                        itemCount: snapshot.data.docs.length,
                                        itemBuilder: (context, index) {
                                          var doc = snapshot.data.docs[index];

                                          var id = snapshot.data.docs[index].id;
                                          var name = snapshot.data.docs[index];
                                          var url;

                                          return GestureDetector(
                                            onTap: () {
                                              url = name["link"];
                                              eventID = id;
                                              eventName = name['title'];
                                              print(url);
                                              print(eventID);
                                              print(eventName);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Events(
                                                            selectedUrl: url,
                                                            eventName:
                                                                eventName,
                                                          )));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6),
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: _height / 9,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  elevation: 5,
                                                  child: Center(
                                                    child: Text(
                                                      doc["title"],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontStyle:
                                                              FontStyle.normal),
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
