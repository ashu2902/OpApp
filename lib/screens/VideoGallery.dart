import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoGallery extends StatefulWidget {
  @override
  _VideoGalleryState createState() => _VideoGalleryState();
}

class _VideoGalleryState extends State<VideoGallery> {
  VideoPlayerController videoPlayerController = VideoPlayerController.network(
      'https://www.youtube.com/watch?v=0pXkT8-aJEw');
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Video Gallery',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.chevron_left_sharp),
            iconSize: 30,
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: _firebaseFirestore.collection('VideoGallery').snapshots(),
          builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasError
                ? Container(
                    child: Center(child: Text('No data')),
                  )
                : snapshot.hasData
                    ? Container(
                        child: VideoPlayer(videoPlayerController),
                      )
                    : Container();
          }),
    );
  }
}
