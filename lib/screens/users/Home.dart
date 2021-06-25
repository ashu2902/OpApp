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
          color: Colors.blue[900],
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.blue[700],
          animationCurve: Curves.easeIn,
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
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold))
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
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold))
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
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
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
        appBar: AppBar(
          centerTitle: true,
          toolbarOpacity: 1,
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            'The OP Bhalla Foundation',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              color: Colors.black,
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        drawer: Drawer(child: DrawerTiles()),
        body: screens[_page]);
  }
}

class DrawerTiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        ListView(addRepaintBoundaries: true, children: [
          DrawerHeader(
              child: Image(
            image: AssetImage("assets/FoundationLogo.png"),
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListTile(
                  title: Text(
                    'Our Initiatives',
                    style: TextStyle(color: Colors.blue[900], fontSize: 18),
                  ),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OurInitiatives()))),
              ListTile(
                title: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      onChanged: (value) {
                        if (value == 'Photo Gallery') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PhotoGallery()));
                        } else if (value == 'Video Gallery') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VideoGallery()));
                        }
                      },
                      hint: Text(
                        'Gallery',
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      items: <String>['Photo Gallery', 'Video Gallery']
                          .map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(
                            value,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList()),
                ),
              ),
              ListTile(
                title: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      onChanged: (value) {
                        if (value == 'Support as Volunteer') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VolunteerSupport(),
                            ),
                          );
                        } else if (value == 'Support as Intern') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InternSupport(),
                            ),
                          );
                        }
                      },
                      hint: Text(
                        'Support Us',
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      items: <String>[
                        'Support as Volunteer',
                        'Support as Intern'
                      ].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList()),
                ),
              ),
              ListTile(
                  title: Text(
                    'Event Registration',
                    style: TextStyle(color: Colors.blue[900], fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventRegistration(),
                      ),
                    );
                  }),
              ListTile(
                  title: Text(
                    'About Us',
                    style: TextStyle(color: Colors.blue[900], fontSize: 18),
                  ),
                  onTap: () {}),
              ListTile(
                  title: Text(
                    'Contact Us',
                    style: TextStyle(color: Colors.blue[900], fontSize: 18),
                  ),
                  onTap: () {}),
            ],
          ),
        ]),
        Positioned(
            left: 1,
            right: 1,
            bottom: 2,
            child: TextButton(
              child: Text(
                'Sign In as Admin',
                style: TextStyle(fontSize: 13, color: Colors.black),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignIn(),
                ),
              ),
            )),
      ]),
    );
  }
}
