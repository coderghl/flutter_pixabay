import 'package:flutter/material.dart';
import 'package:flutter_pixabay/widgets/vidoe_player_full_screen_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerControlPad extends StatefulWidget {
  const VideoPlayerControlPad({
    super.key,
    required this.controller,
    this.isFullScreen = false,
  });

  final VideoPlayerController controller;
  final bool isFullScreen;

  @override
  State<VideoPlayerControlPad> createState() => _VideoPlayerControlPadState();
}

class _VideoPlayerControlPadState extends State<VideoPlayerControlPad> {
  bool _showControlPad = false;
  bool _isPlaying = true;
  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool _isBuffering = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    _duration = widget.controller.value.duration;
    _isPlaying = widget.controller.value.isPlaying;
    _position = widget.controller.value.position;
    widget.controller.addListener(() {
      if (mounted) {
        setState(() {
          _position = widget.controller.value.position;
          _handelState();
        });
      }
    });
  }

  void _handelState() {
    _isBuffering = widget.controller.value.isBuffering;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      onDoubleTap: _onDoubleTap,
      child: Container(
          width: double.infinity,
          height: 200,
          decoration: const BoxDecoration(),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              if (widget.isFullScreen) _buildTopBar(context),
              _buildBuffer(),
              _buildSlider(),
            ],
          )),
    );
  }

  dynamic _buildBuffer() {
    return _isBuffering
        ? const Center(child: CircularProgressIndicator())
        : const SizedBox();
  }

  Widget _buildTopBar(BuildContext context) {
    return AnimatedAlign(
      duration: const Duration(milliseconds: 400),
      alignment: _showControlPad ? Alignment.topLeft : const Alignment(-1, -2),
      child: Container(
        width: double.infinity,
        height: 54,
        alignment: Alignment.topLeft,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black12,
              Colors.black26,
            ],
            stops: [.4, .6],
          ),
        ),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSlider() {
    return AnimatedAlign(
      alignment:
          _showControlPad ? Alignment.bottomCenter : const Alignment(0, 2),
      duration: const Duration(milliseconds: 400),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black26,
              Colors.black12,
            ],
            stops: [.4, .6],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _onDoubleTap,
              icon: Icon(
                _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 24,
                child: Slider(
                  onChanged: (double value) {
                    setState(() {
                      widget.controller
                          .seekTo(Duration(seconds: value.toInt()));
                    });
                  },
                  max: _duration.inSeconds.toDouble(),
                  value: _position.inSeconds.toDouble(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                "${formatDuration(_position)}/${formatDuration(_duration)}",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
              onPressed: _onFullScreen,
              icon: const Icon(
                Icons.fullscreen_exit_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    setState(() {
      _showControlPad = !_showControlPad;
    });
  }

  void _onDoubleTap() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        widget.controller.play();
      } else {
        widget.controller.pause();
      }
    });
  }

  void _onFullScreen() {
    if (widget.isFullScreen) {
      Navigator.pop(context);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerFullScreenWidget(
            controller: widget.controller,
          ),
        ),
      );
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours > 0) {
      String twoDigitHours = twoDigits(duration.inHours);
      return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
    } else {
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
  }
}
