import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:opbhallafoundation/screens/WebViewScreens/SpotlightWeb.dart';

class Spotlight extends StatefulWidget {
  @override
  _SpotlightState createState() => _SpotlightState();
}

class _SpotlightState extends State<Spotlight> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xffff6b5c),
          title: Text(
            'SPOTLIGHTS',
            textAlign: TextAlign.center,
          ),
        ),
        body: StreamBuilder(
            stream: _firebaseFirestore.collection('Spotlights').snapshots(),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              return snapshot.hasError
                  ? Container()
                  : snapshot.hasData
                      ? Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemExtent: _height / 3.9,
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, index) {
                                      var doc = snapshot.data.docs[index];
                                      var img = snapshot.data.docs[index];
                                      return snapshot.hasData
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6),
                                              child: GestureDetector(
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  clipBehavior: Clip.hardEdge,
                                                  elevation: 10,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: Container(
                                                          clipBehavior:
                                                              Clip.hardEdge,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30)),
                                                          child:
                                                              Stack(children: [
                                                            Container(
                                                              child:
                                                                  Image.network(
                                                                img["img"],
                                                                fit: BoxFit
                                                                    .cover,
                                                                width: _width /
                                                                    2.2,
                                                                height: _height,
                                                              ),
                                                            ),
                                                            Positioned(
                                                              left: _width / 13,
                                                              bottom:
                                                                  _height / 66,
                                                              child: Container(
                                                                child: Icon(
                                                                  Icons
                                                                      .calendar_today_rounded,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 24,
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                                left:
                                                                    _width / 7,
                                                                bottom:
                                                                    _height /
                                                                        51,
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.0),
                                                                  child: Text(
                                                                    doc['Date'],
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ))
                                                          ]),
                                                        ),
                                                      ),
                                                      SingleChildScrollView(
                                                        child: Container(
                                                          width: _width / 2.7,
                                                          child: Text(
                                                            '${doc['Name']}',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SpotlightWebView(
                                                                selectedUrl: doc[
                                                                    'link']))),
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
