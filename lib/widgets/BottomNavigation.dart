import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return CurvedNavigationBar(
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
        Icon(Icons.home, size: 36, color: Colors.black, semanticLabel: 'Home'),
        Icon(Icons.calendar_today_outlined, size: 36, color: Colors.black),
      ],
    );
  }
}
