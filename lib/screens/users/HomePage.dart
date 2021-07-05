import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opbhallafoundation/widgets/AppBarWidget.dart';
import 'package:opbhallafoundation/widgets/Carousels.dart';
import 'package:opbhallafoundation/widgets/RecentActivitiesList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Container(
      width: _width,
      color: Colors.grey[100],
      height: _height,
      child: Stack(
        children: [
          AppBarWidget(heading: 'Home'),
          Positioned(
              top: _height / 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Highlights',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Colors.white),
                ),
              )),
          Positioned(top: _height / 5, child: HighlightsCarousel()),
          Positioned(
              top: _height / 1.9,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  'Recent Activities',
                  style: TextStyle(fontSize: 23),
                ),
              )),
          Positioned(
              top: _height / 1.8,
              width: _width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: RecentActivitiesList(),
              ))
        ],
      ),
    );
  }
}
