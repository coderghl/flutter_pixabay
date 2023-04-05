import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/video_entity.dart';
import 'package:flutter_pixabay/widgets/video_player_control_pad.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
    required this.data,
  });

  final VideoEntity data;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    print(widget.data.videos.tiny.url);
    _controller = VideoPlayerController.network(
      widget.data.videos.tiny.url,
    )..initialize().then((_) {
        _controller.play();
        setState(() {
          _isInitialized = true;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: _isInitialized
          ? Stack(
              children: [
                Hero(tag: "videoPlayer", child: VideoPlayer(_controller)),
                VideoPlayerControlPad(
                  controller: _controller,
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
