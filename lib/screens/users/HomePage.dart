import 'package:flutter/material.dart';
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
      color: Colors.white,
      height: _height,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(top: 40, bottom: 8),
              //   child: Text(
              //     'Highlights',
              //     style: TextStyle(fontSize: 18, color: Colors.black45),
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HighlightsCarousel(),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Recent Activities',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              // RecentActivitiesCarousel(),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: RecentActivitiesList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
