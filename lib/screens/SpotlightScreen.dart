import 'package:flutter/material.dart';

class Spotlight extends StatefulWidget {
  @override
  _SpotlightState createState() => _SpotlightState();
}

class _SpotlightState extends State<Spotlight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(child: Text('Spotlights')),
    ));
  }
}
