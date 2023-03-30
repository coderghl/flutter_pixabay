import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/video_entity.dart';
import 'package:flutter_pixabay/utils/network/api/download_api.dart';
import 'package:flutter_pixabay/utils/permission/permission_util.dart';
import 'package:flutter_pixabay/widgets/video_player_widget.dart';
import 'package:permission_handler/permission_handler.dart';

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
  final DownloadApi _downloadApi = DownloadApi();

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
                _buildDownloadBtn(),
              ],
            ),
          )
        ],
      ),
    );
  }

  MenuAnchor _buildDownloadBtn() {
    return MenuAnchor(
      menuChildren: [
        MenuItemButton(
          onPressed: () =>
              _permissionCheckBeforeDownload(widget.data.videos.large.url),
          child: Text(
            ("${widget.data.videos.large.width}x${widget.data.videos.large.height}"),
          ),
        ),
        MenuItemButton(
          onPressed: () =>
              _permissionCheckBeforeDownload(widget.data.videos.medium.url),
          child: Text(
            ("${widget.data.videos.medium.width}x${widget.data.videos.medium.height}"),
          ),
        ),
        MenuItemButton(
          onPressed: () =>
              _permissionCheckBeforeDownload(widget.data.videos.small.url),
          child: Text(
            ("${widget.data.videos.small.width}x${widget.data.videos.small.height}"),
          ),
        ),
        MenuItemButton(
          onPressed: () =>
              _permissionCheckBeforeDownload(widget.data.videos.tiny.url),
          child: Text(
            ("${widget.data.videos.tiny.width}x${widget.data.videos.tiny.height}"),
          ),
        ),
      ],
      builder: (context, controller, child) => FilledButton.tonal(
        onPressed: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        child: child,
      ),
      child: const Text("Download"),
    );
  }

  /// 1. check permission
  /// 2. download
  void _permissionCheckBeforeDownload(String url) async {
    // 1.
    bool isPermission =
        await PermissionUtil.checkPermission(Permission.storage);
    if (isPermission) {
      _handelDownload(url);
    } else {
      var requestResult =
          await PermissionUtil.requestPermission(Permission.storage);
      if (requestResult) {
        _handelDownload(url);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Permissions must be granted to download the video to your phone"),
          ),
        );
      }
    }
  }

  void _handelDownload(String url) async {
    _downloadApi.downloadVideo(url: url);
  }
}
