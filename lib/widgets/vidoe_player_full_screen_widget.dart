import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pixabay/widgets/video_player_control_pad.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerFullScreenWidget extends StatefulWidget {
  VideoPlayerFullScreenWidget({
    super.key,
    required this.controller,
  });

  final VideoPlayerController controller;

  @override
  State<VideoPlayerFullScreenWidget> createState() =>
      _VideoPlayerFullScreenWidgetState();
}

class _VideoPlayerFullScreenWidgetState
    extends State<VideoPlayerFullScreenWidget> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(tag: "videoPlayer", child: VideoPlayer(widget.controller)),
            VideoPlayerControlPad(
              controller: widget.controller,
              isFullScreen: true,
            ),
          ],
        ),
      ),
    );
  }
}
