import 'package:flutter/material.dart';

class NewAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: _height / 10,
            child: AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              centerTitle: false,
              toolbarOpacity: 1,
              elevation: 0,
              backgroundColor: Color(0xffff6b5c),
              automaticallyImplyLeading: false,
              title: Text(
                'The OP Bhalla Foundation',
                style: TextStyle(color: Colors.black, fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
