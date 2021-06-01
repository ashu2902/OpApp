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
        color: Colors.white,
        width: _width / 1.05,
        height: _height / 2.52,
        child: StreamBuilder(
          stream: _firestore.collection('RecentActivities').snapshots(),
          builder: (context, snapshot) {
            return snapshot.hasError
                ? Center(
                    child: Container(
                    child: Text('Error'),
                  ))
                : snapshot.hasData
                    ? ListView.builder(
                        itemExtent: _height / 6,
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          var doc = snapshot.data.docs[index].data();
                          var img = snapshot.data.docs[index].data();
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: Material(
                                    child: Container(
                                      height: _height / 2,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                img['url'],
                                                fit: BoxFit.fill,
                                                width: _height / 4,
                                                height: _height / 4,
                                              ),
                                            ),
                                            Text(
                                              doc['desc'],
                                              style: TextStyle(fontSize: 18),
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
                              elevation: 4,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            height: _height,
                                            width: _width / 3,
                                            child: Image.network(
                                              img['url'],
                                              fit: BoxFit.fill,
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
                                              maxLines: 6,
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
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
          },
        ));
  }
}
