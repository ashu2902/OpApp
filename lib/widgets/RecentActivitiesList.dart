import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecentActivitiesList extends StatefulWidget {
  @override
  _RecentActivitiesListState createState() => _RecentActivitiesListState();
}

class _RecentActivitiesListState extends State<RecentActivitiesList> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Container(
      width: _width / 1.1,
      height: _height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.2),
        //     spreadRadius: 1.5,
        //     blurRadius: 2,
        //     offset: Offset(0, 3), // changes position of shadow
        //   ),
        // ],
      ),
      child: StreamBuilder(
        stream: _firestore.collection('RecentActivities').snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasError
              ? Center(
                  child: Container(
                  child: Text('Error'),
                ))
              : snapshot.hasData
                  ? Container(
                      child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemExtent: _height / 6,
                        shrinkWrap: false,
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          var doc = snapshot.data.docs[index].data();
                          var img = snapshot.data.docs[index].data();
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                  clipBehavior: Clip.hardEdge,
                                  insetAnimationCurve: Curves.easeIn,
                                  insetAnimationDuration: Duration(seconds: 2),
                                  child: Material(
                                    child: Container(
                                      color: Colors.white,
                                      height: _height / 1.5,
                                      width: _width,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Card(
                                                  elevation: 0,
                                                  child: Container(
                                                    color: Colors.black,
                                                    child: Image.network(
                                                      img['url'],
                                                      fit: BoxFit.fill,
                                                      width: _height / 2,
                                                      height: _height / 4,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.black12),
                                                width: _width / 1.5,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    doc['desc'],
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Container(
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(5),
                                            width: _width / 3,
                                            height: _height,
                                            decoration: BoxDecoration(
                                                color: Colors.black12
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Center(
                                              child: Image.network(
                                                img['url'],
                                                fit: BoxFit.fill,
                                                height: _height,
                                                width: _width,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(4),
                                            height: _height / 4,
                                            width: _width / 2.5,
                                            child: Text(
                                              doc['desc'],
                                              style: TextStyle(fontSize: 16),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 4,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
        },
      ),
    );
  }
}
