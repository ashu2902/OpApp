import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:opbhallafoundation/screens/SpotlightScreen.dart';
import 'package:opbhallafoundation/screens/WebViewScreens/Donate.dart';
import 'package:opbhallafoundation/screens/users/Home.dart';
import 'package:opbhallafoundation/screens/users/HomePage.dart';
import 'package:opbhallafoundation/widgets/Carousels.dart';

import 'RecentActivitiesList.dart';

class NewAppBar extends StatefulWidget {
  @override
  State<NewAppBar> createState() => _NewAppBarState();
}

class _NewAppBarState extends State<NewAppBar> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  int _page = 1;
  final screens = [Donate(), HomePage(), Spotlight()];
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page,
        height: _height / 15,
        color: Color(0xffff6b5c),
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Color(0xffff6b5c),
        animationCurve: Curves.ease,
        animationDuration: Duration(milliseconds: 300),
        items: <Widget>[
          Container(
            color: Colors.transparent,
            height: _height / 18,
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.attach_money,
                      size: 29, color: Colors.black, semanticLabel: 'Donate'),
                  Text('Donate',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
          Container(
            height: _height / 18,
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.home,
                      size: 29, color: Colors.black, semanticLabel: 'Home'),
                  Text('Home',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
          Container(
            height: _height / 18,
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.calendar_today_outlined,
                      size: 29, color: Colors.black),
                  Expanded(
                      child: Text(
                    'Spotlights',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ))
                ],
              ),
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      drawer: Drawer(child: DrawerTiles()),
      body: Container(
        height: _height,
        child: Stack(children: [
          Container(
            height: _height / 4,
            child: AppBar(
              leading: Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu),
                  color: Colors.black,
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(42)),
              centerTitle: false,
              toolbarOpacity: 1,
              elevation: 0,
              backgroundColor: Color(0xffff6b5c),
              automaticallyImplyLeading: false,
              title: Text(
                'The OP Bhalla Foundation',
                style: TextStyle(color: Colors.black, fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
              top: _height / 6,
              child: Container(
                width: _width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 6),
                      child: Container(
                        width: _width,
                        child: Text(
                          'HIGHLIGHTS',
                          style: TextStyle(fontSize: 21),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    HighlightsCarousel(),
                  ],
                ),
              )),

          Positioned(
            bottom: _height / 2.6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Recent Activities',
                style: TextStyle(fontSize: 21),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          // RecentActivitiesCarousel(),
          Positioned(
              bottom: _height / 75,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: RecentActivitiesList(),
              ))
        ]),
      ),
    );
  }
}
