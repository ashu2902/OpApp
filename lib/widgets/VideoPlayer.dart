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
        _controller.setLooping(true);
        _controller.seekTo(Duration(seconds: 0));

        setState(() {});
      });
  }

  Future goToPosition(
    Duration Function(Duration currentPosition) builder,
  ) async {
    final currentPosition = await _controller.position;
    final newPosition = builder(currentPosition);
    await _controller.seekTo(newPosition);
  }

  Future rewindFiveSeconds() async =>
      goToPosition((currentPosition) => currentPosition - Duration(seconds: 5));
  Future forwardFiveSeconds() async =>
      goToPosition((currentPosition) => currentPosition + Duration(seconds: 5));

  pauseorplay() {
    setState(() {
      _controller.value.isPlaying
          ? widget.icon = Icons.play_arrow_rounded
          : widget.icon = Icons.pause_rounded;
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
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
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xffff6b5c),
        title: Text('Video Gallery'),
      ),
      body: Container(
        color: Colors.grey[300],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: _height,
                child: _controller.value.isInitialized
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                          Container(
                            height: 12,
                            width: _width / 1.25,
                            child: VideoProgressIndicator(_controller,
                                allowScrubbing: true),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  splashRadius: 30,
                                  onPressed: () => rewindFiveSeconds(),
                                  icon: Icon(Icons.replay_5_rounded, size: 42)),
                              IconButton(
                                  onPressed: () => pauseorplay(),
                                  icon: Icon(widget.icon, size: 42)),
                              IconButton(
                                  onPressed: () => forwardFiveSeconds(),
                                  icon: Icon(Icons.forward_5_rounded, size: 42))
                            ],
                          )
                        ],
                      )
                    : Center(child: CircularProgressIndicator())),
          ),
        ),
      ),
    );
  }
}
