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
    return SingleChildScrollView(
      child: Container(
        width: _width,
        color: Colors.grey[200],
        height: _height * 1.1,
        child: Stack(
          children: [
            AppBarWidget(heading: 'DR. O P Bhalla Foundation'),
            Positioned(
                top: _height / 6.6,
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
            Positioned(
              top: _height / 5,
              child: HighlightsCarousel(),
            ),
            Positioned(
                top: _height / 1.9,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Recent Activities',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: Color(0xffff6b5c)),
                  ),
                )),
            Positioned(
                top: _height / 1.8,
                width: _width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: RecentActivitiesList(),
                ))
          ],
        ),
      ),
    );
  }
}
