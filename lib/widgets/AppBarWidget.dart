import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final heading;
  AppBarWidget({@required this.heading});
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(102)),
        gradient: LinearGradient(
          colors: [
            Color(0xffff6b5c).withOpacity(0.9),
            Color(0xffff6b5c),
            Colors.red
          ],
          stops: [0.2, 0.5, 0.9],
        ),
      ),
      height: _height / 3,
      child: AppBar(
        elevation: 0,
        title: Text(heading),
        centerTitle: true,
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(102),
          ),
        ),
        bottom: PreferredSize(
          child: Container(),
          preferredSize: Size.fromHeight(_height / 4),
        ),
      ),
    );
  }
}
