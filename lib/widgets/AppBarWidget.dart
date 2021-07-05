import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final heading;
  AppBarWidget({@required this.heading});
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Container(
      height: _height / 3,
      child: AppBar(
        elevation: 20,
        title: Text(heading),
        centerTitle: true,
        backgroundColor: Color(0xffff6b5c),
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
