import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(2),
      height: _height / 3.4,
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
                                Card(
                                  borderOnForeground: false,
                                  clipBehavior: Clip.hardEdge,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                  elevation: 2,
                                  child: Container(
                                    height: _height,
                                    width: _width,
                                    child: Card(
                                      child: ClipRect(
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.network(
                                          e.get('url'),
                                          fit: BoxFit.fill,
                                          scale: .5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Container(
                                      height: _height / 10,
                                      width: _width / 1.3,
                                      color: Colors.white10.withOpacity(0.2),
                                      child: Text(
                                        e.get('desc'),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                          height: _height / 3,
                          autoPlayAnimationDuration: Duration(seconds: 1),
                          autoPlayInterval: Duration(seconds: 2),
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                          viewportFraction: 0.8),
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
