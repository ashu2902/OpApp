import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:opbhallafoundation/screens/Admin/Authentication/SignIn.dart';
import 'package:opbhallafoundation/screens/EventRegistration.dart';
import 'package:opbhallafoundation/screens/OurInitiatives.dart';
import 'package:opbhallafoundation/screens/PhotoGallery.dart';
import 'package:opbhallafoundation/screens/SpotlightScreen.dart';
import 'package:opbhallafoundation/screens/VideoGallery.dart';
import 'package:opbhallafoundation/screens/WebViewScreens/Donate.dart';
import 'package:opbhallafoundation/screens/WebViewScreens/SupportAsIntern.dart';
import 'package:opbhallafoundation/screens/WebViewScreens/SupportAsVolunteer.dart';
import 'package:opbhallafoundation/screens/users/HomePage.dart';
import 'package:opbhallafoundation/widgets/AppBarWidget.dart';
import 'package:opbhallafoundation/widgets/DrawerTiles.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  int _page = 1;
  final screens = [Donate(), HomePage(), Spotlight()];
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: true,
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
                    Icon(Icons.attach_money_rounded,
                        size: 29, color: Colors.white, semanticLabel: 'Donate'),
                    Text('Donate',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
            Container(
              height: _height / 18,
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.home_rounded,
                        size: 29, color: Colors.white, semanticLabel: 'Home'),
                    Text('Home',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
            Container(
              height: _height / 18,
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.calendar_today, size: 29, color: Colors.white),
                    Expanded(
                        child: Text(
                      'Spotlights',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
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
        body: screens[_page]);
  }
}
