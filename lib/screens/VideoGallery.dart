import 'package:flutter/material.dart';

class VideoGallery extends StatefulWidget {
  @override
  _VideoGalleryState createState() => _VideoGalleryState();
}

class _VideoGalleryState extends State<VideoGallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('video')),
      ),
    );
  }
}
