import 'package:flutter/material.dart';

class PhotoGallery extends StatefulWidget {
  @override
  _PhotoGalleryState createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('Photo')),
      ),
    );
  }
}
