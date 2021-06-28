import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerWidget({@required this.url});
  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
  final String url;
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        _controller.setVolume(1);
        
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Center(child: CircularProgressIndicator())),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          _controller.value.isPlaying
              ? _controller.pause()
              : _controller.play();
          _controller.value.isBuffering
              ? CircularProgressIndicator()
              : Container();
        });
      }),
    );
  }
}
