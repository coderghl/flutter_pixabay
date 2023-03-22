import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/video_entity.dart';
import 'package:flutter_pixabay/widgets/video_player_widget.dart';

class VideoDetailsPage extends StatefulWidget {
  const VideoDetailsPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  final VideoEntity data;

  @override
  State<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends State<VideoDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_rounded)),
        ],
      ),
      body: Column(
        children: [
          VideoPlayerWidget(url: widget.data.videos.medium.url),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.data.userImageUrl),
                    ),
                    const SizedBox(width: 8),
                    Text(widget.data.user),
                  ],
                ),
                FilledButton(
                  onPressed: _downloadVideo,
                  child: const Text("Download"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _downloadVideo() {}
}
