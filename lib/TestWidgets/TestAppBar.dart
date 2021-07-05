import 'package:flutter/material.dart';

class TestAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
        ),
        bottom: PreferredSize(
            child: Container(), preferredSize: Size.fromHeight(_height / 4)),
      ),
    );
  }
}
