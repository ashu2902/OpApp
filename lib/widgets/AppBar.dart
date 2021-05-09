import 'package:flutter/material.dart';

Widget appBar(String text, IconButton iconButton) {
  return AppBar(
    title: Text(
      text,
    ),
    centerTitle: true,
    leading: IconButton(icon: iconButton, onPressed: () {}),
    
  );
}
