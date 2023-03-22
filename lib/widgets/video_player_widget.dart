import 'package:flutter/material.dart';
import 'package:flutter_pixabay/widgets/video_player_control_pad.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
    required this.url,
  });

  final String url;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // 播放视频
        _controller.play();
        // 循环播放
        _controller.setLooping(true);
        // 更新页面状态
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
          : const ColoredBox(color: Colors.black),
    );
  }
}
