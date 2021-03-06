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
        stream: _firestore
            .collection("highlights")
            .orderBy('serial', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasError
              ? Center(
                  child: Text("There is some problem loading your images"),
                )
              : snapshot.hasData
                  ? CarouselSlider(
                      items: snapshot.data.docs
                          .map(
                            (e) => GestureDetector(
                              onTap: () {
                                debugPrint('tapped');
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    clipBehavior: Clip.hardEdge,
                                    insetAnimationCurve: Curves.bounceIn,
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
                                                        e.get('url'),
                                                        fit: BoxFit.cover,
                                                        width: _height / 2,
                                                        height: _height / 4,
                                                        loadingBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Widget child,
                                                                ImageChunkEvent
                                                                    loadingProgress) {
                                                          if (loadingProgress ==
                                                              null) {
                                                            return child;
                                                          }
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              value: loadingProgress
                                                                          .expectedTotalBytes !=
                                                                      null
                                                                  ? loadingProgress
                                                                          .cumulativeBytesLoaded /
                                                                      loadingProgress
                                                                          .expectedTotalBytes
                                                                  : null,
                                                            ),
                                                          );
                                                        },
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
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      e.get('desc'),
                                                      style: TextStyle(
                                                          fontSize: 18),
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
                                clipBehavior: Clip.hardEdge,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                                elevation: 3,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: _height,
                                      width: _width,
                                      child: ClipRect(
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.network(
                                          e.get('url'),
                                          filterQuality: FilterQuality.low,
                                          fit: BoxFit.fill,
                                          scale: 1,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        height: _height / 10,
                                        width: _width / 1.25,
                                        color: Colors.black.withOpacity(0.6),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            e.get('title'),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
