import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:opbhallafoundation/screens/Admin/Authentication/SignIn.dart';
import 'package:opbhallafoundation/screens/OurInitiatives.dart';
import 'package:opbhallafoundation/widgets/Carousels.dart';
import 'package:opbhallafoundation/widgets/RecentActivitiesList.dart';

import '../SupportUs.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        height: _height / 17,
        color: Colors.blue[900],
        backgroundColor: Colors.white.withOpacity(0.0),
        buttonBackgroundColor: Colors.blue[700],
        animationCurve: Curves.easeIn,
        animationDuration: Duration(milliseconds: 250),
        items: <Widget>[
          Icon(Icons.attach_money,
              size: 36, color: Colors.black, semanticLabel: 'Donate'),
          Icon(Icons.home,
              size: 36, color: Colors.black, semanticLabel: 'Home'),
          Icon(Icons.calendar_today_outlined, size: 36, color: Colors.black),
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
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
      body: Container(
        width: _width,
        color: Colors.white,
        height: _height,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(top: 40, bottom: 8),
                //   child: Text(
                //     'Highlights',
                //     style: TextStyle(fontSize: 18, color: Colors.black45),
                //   ),
                // ),
                SizedBox(
                  height: _height / 25,
                ),
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
                RecentActivitiesList()
              ],
            ),
          ),
        ),
      ),
    );
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
                  title: Text(
                    'Gallery',
                    style: TextStyle(color: Colors.blue[900], fontSize: 18),
                  ),
                  onTap: () {}),
              ListTile(
                title: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      onChanged: (value) {
                        if (value == 'Support as Volunteer') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SupportAsVolunteer()));
                        } else if (value == 'Support as Intern') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SupportAsIntern()));
                        }
                      },
                      hint: Text(
                        'Support Us',
                        style: TextStyle(color: Colors.blue[900], fontSize: 18),
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
                  onTap: () {}),
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
