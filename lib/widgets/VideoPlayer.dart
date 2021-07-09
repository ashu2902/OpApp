import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerWidget({@required this.url});
  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
  final String url;
  var icon = Icons.play_arrow_rounded;
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
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: _height / 3,
              child: _controller.value.isInitialized
                  ? Column(
                      children: [
                        AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () => pauseorplay(),
                                child: Icon(widget.icon)),
                          ],
                        )
                      ],
                    )
                  : Center(child: CircularProgressIndicator())),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(widget.icon),
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? widget.icon = Icons.play_arrow_rounded
                  : widget.icon = Icons.pause_rounded;
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          }),
    );
  }

  pauseorplay() {
    setState(() {
      _controller.value.isPlaying
          ? widget.icon = Icons.play_arrow_rounded
          : widget.icon = Icons.pause_rounded;
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }
}
