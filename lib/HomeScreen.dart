import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:opbhallafoundation/widgets.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: _height / 15,
        backgroundColor: Colors.black26,
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('Op Bhalla Foundation'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white10,
          child: ImageSlider(),
        ),
      ),
    );
  }
}
