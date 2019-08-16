import 'package:flutter/material.dart';
import 'package:flutter_app_lecture_04/resources/textstyle.dart';
import 'package:video_player/video_player.dart';

var videoUrl =
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVidoePlayer;

  @override
  void initState() {
    _controller = VideoPlayerController.network(videoUrl);
    _initializeVidoePlayer = _controller.initialize();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mini Netflix',
          style: appBarStyle,
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).maybePop();
          },
          child: Icon(Icons.arrow_back, color: Colors.red),
        ),
      ),
      body: FutureBuilder(
        future: _initializeVidoePlayer,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });


        },
        backgroundColor: Colors.white,
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_circle_filled,
          size: 32,
          color: Colors.black,
        ),
      ),
    );
  }
}
