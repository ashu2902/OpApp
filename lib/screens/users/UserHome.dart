import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 300),
        index: 1,
        height: _height / 15,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.blue,
        items: <Widget>[
          Icon(
            Icons.monetization_on_outlined,
            size: 40,
            key: Key('Donate'),
          ),
          Icon(Icons.home, size: 40),
          Icon(Icons.calendar_today_outlined, size: 40),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DonationScreen()));
          }
          if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserHomePage()));
          }
          if (index == 2) {
            return Container(child: Text('Spotlight'));
          }
        },
      ),
      appBar: AppBar(
        title: Text(
          'The OP Bhalla Foundation',
          textAlign: TextAlign.center,
        ),
      ),
      drawer: Drawer(child: ListTile(),),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection("images").snapshots(),
          builder: (context, snapshot) {
            return snapshot.hasError
                ? Center(
                    child: Text("There is some problem loading your images"),
                  )
                : snapshot.hasData
                    ? ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              margin: const EdgeInsets.only(top: 1.0),
                              height: _height / 18,
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Highlights ',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 24),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: _height / 3,
                            width: _width / 2,
                            child: CarouselSlider(
                              items: snapshot.data.docs
                                  .map(
                                    (e) => Stack(
                                      children: [
                                        Container(
                                          width: _width,
                                          height: _height,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.transparent),
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
                                            color: const Color(0xFF696969)
                                                .withOpacity(0.5),
                                            child: Text(
                                              'This is a text',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                              options: CarouselOptions(
                                  height: _height,
                                  autoPlayAnimationDuration:
                                      Duration(seconds: 2),
                                  autoPlayInterval: Duration(seconds: 6),
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              margin: const EdgeInsets.only(top: 1.0),
                              height: _height / 18,
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Recent Activities',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 24),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: _height / 3,
                            child: Container(
                              child: CarouselSlider(
                                items: snapshot.data.docs
                                    .map((e) => Image.network(
                                          e.get('url'),
                                          height: _height,
                                          width: _width,
                                          fit: BoxFit.cover,
                                        ))
                                    .toList(),
                                options: CarouselOptions(
                                  autoPlayAnimationDuration:
                                      Duration(seconds: 2),
                                  autoPlayInterval: Duration(seconds: 6),
                                  height: _height,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  aspectRatio: 16 / 9,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container();
          },
        ),
      ),
    );
  }
}

class DonationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class DrawerTiles extends StatelessWidget {
  @override
  Widget build(BuildContext context ) {
    return Container(
      
    );
  }
}