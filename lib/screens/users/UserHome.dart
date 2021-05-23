import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:opbhallafoundation/screens/Admin/Authentication/SignIn.dart';
import 'package:opbhallafoundation/screens/Admin/Categories.dart';
import 'package:opbhallafoundation/widgets/Carousels.dart';

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
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      // bottomNavigationBar: CurvedNavigationBar(
      //   animationDuration: Duration(milliseconds: 800),
      //   index: 1,
      //   height: 75,
      //   color: Colors.redAccent,
      //   backgroundColor: Colors.white,
      //   buttonBackgroundColor: Colors.transparent,
      //   animationCurve: Curves.bounceIn,
      //   items: <Widget>[
      //     Icon(Icons.monetization_on_outlined,
      //         size: 46, color: Colors.black, semanticLabel: 'Donate'),
      //     Icon(Icons.home,
      //         size: 46, color: Colors.black, semanticLabel: 'Home'),
      //     Icon(Icons.calendar_today_outlined, size: 46, color: Colors.black),
      //   ],
      //   onTap: (index) {
      //     if (index == 0) {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => DonationScreen(),
      //         ),
      //       );
      //     }
      //     if (index == 1) {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => UserHomePage(),
      //         ),
      //       );
      //     }
      //     if (index == 2) {
      //       return Container(
      //         child: Text('Spotlight'),
      //       );
      //     }
      //   },
      // ),
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
      drawer: Drawer(
        child: ListTile(
          title: Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Categories(),
                  ),
                );
              },
              child: TextButton(
                child: Text('Sign In as Admin'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignIn(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Highlights',
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                ),
              ),
              HighlightsCarousel(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Recent Activities',
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                ),
              ),
              RecentActivitiesCarousel(),
            ],
          ),
        ),
      ),
    );
  }
}

class DonationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          animationDuration: Duration(milliseconds: 800),
          index: 0,
          height: 75,
          color: Colors.redAccent,
          backgroundColor: Colors.white,
          buttonBackgroundColor: Colors.transparent,
          animationCurve: Curves.bounceIn,
          items: <Widget>[
            Icon(Icons.monetization_on_outlined,
                size: 46, color: Colors.black, semanticLabel: 'Donate'),
            Icon(Icons.home,
                size: 46, color: Colors.black, semanticLabel: 'Home'),
            Icon(Icons.calendar_today_outlined, size: 46, color: Colors.black),
          ],
          onTap: (index) {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DonationScreen(),
                ),
              );
            }
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserHomePage(),
                ),
              );
            }
            if (index == 2) {
              return Container(
                child: Text('Spotlight'),
              );
            }
          },
        ),
        body: Container(
          child: Center(child: Text('Donation Screen')),
        ));
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
  Widget build(BuildContext context) {
    return Container();
  }
}
