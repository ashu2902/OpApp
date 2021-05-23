import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecentActivitiesCarousel extends StatefulWidget {
  @override
  _RecentActivitiesCarouselState createState() =>
      _RecentActivitiesCarouselState();
}

class _RecentActivitiesCarouselState extends State<RecentActivitiesCarousel> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height / 3,
      child: Container(
        padding: const EdgeInsets.all(2),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection("RecentActivities").snapshots(),
          builder: (context, snapshot) {
            return snapshot.hasError
                ? Center(
                    child: Text("There is some problem loading your images"),
                  )
                : snapshot.hasData
                    ? Container(
                        height: _height / 3,
                        width: _width,
                        child: CarouselSlider(
                          items: snapshot.data.docs
                              .map(
                                (e) => Stack(
                                  children: [
                                    Container(
                                      width: _width,
                                      height: _height,
                                      child: Image.network(
                                        e.get('url'),
                                        fit: BoxFit.cover,
                                        scale: 1,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        height: _height / 9,
                                        width: _width,
                                        color:
                                            const Color(0xF).withOpacity(0.5),
                                        child: Text(
                                          e.get('desc'),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                              height: _height,
                              autoPlayAnimationDuration: Duration(seconds: 2),
                              autoPlayInterval: Duration(seconds: 6),
                              autoPlay: true,
                              enlargeCenterPage: true,
                              aspectRatio: 16 / 9,
                              viewportFraction: .8),
                        ),
                      )
                    : Container();
          },
        ),
      ),
    );
  }
}

class HighlightsCarousel extends StatefulWidget {
  @override
  _HighlightsCarouselState createState() => _HighlightsCarouselState();
}

class _HighlightsCarouselState extends State<HighlightsCarousel> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(2),
      height: _height / 3,
      width: _width,
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("highlights").snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasError
              ? Center(
                  child: Text("There is some problem loading your images"),
                )
              : snapshot.hasData
                  ? CarouselSlider(
                      items: snapshot.data.docs
                          .map(
                            (e) => Stack(
                              children: [
                                Container(
                                  height: _height,
                                  width: _width,
                                  child: Image.network(
                                    e.get('url'),
                                    fit: BoxFit.cover,
                                    scale: 1,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    height: _height / 10,
                                    width: _width,
                                    color: const Color(0xF).withOpacity(0.5),
                                    child: Text(
                                      e.get('desc'),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                          height: _height,
                          autoPlayAnimationDuration: Duration(seconds: 2),
                          autoPlayInterval: Duration(seconds: 6),
                          autoPlay: false,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1),
                    )
                  : Container();
        },
      ),
    );
  }
}
