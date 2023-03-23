import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/image_entity.dart';
import 'package:flutter_pixabay/utils/network/api/download_api.dart';

class ImageDetailsPage extends StatefulWidget {
  const ImageDetailsPage({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final List<ImageEntity> data;
  final int index;

  @override
  State<ImageDetailsPage> createState() => _ImageDetailsPageState();
}

class _ImageDetailsPageState extends State<ImageDetailsPage> {
  int _index = 0; // currentPage
  DownloadApi api = DownloadApi();

  late PageController controller;

  @override
  void initState() {
    _index = widget.index;
    controller = PageController(initialPage: _index);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _handelPageChange(int index) {
    _index = index;
    setState(() {});
  }

  void _handelViewOriginalPhoto() {
    widget.data[_index].originalPhoto = true;
    setState(() {});
  }

  void _handelDownload() async {
    bool result =
        await api.downloadImage(url: widget.data[_index].largeImageUrl);
    if (result) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Download success")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Download fail")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("${_index + 1}/${widget.data.length}"),
          actions: [
            _buildPopupMenu(),
          ],
        ),
        body: _buildPage(),
      ),
    );
  }

  PageView _buildPage() {
    return PageView.builder(
      pageSnapping: true,
      controller: controller,
      itemCount: widget.data.length,
      onPageChanged: _handelPageChange,
      itemBuilder: (context, index) {
        var image = widget.data[index];
        return _buildItem(image);
      },
    );
  }

  Widget _buildItem(ImageEntity image) {
    return Hero(
      tag: image.webformatUrl,
      child: InteractiveViewer(
        maxScale: 5,
        minScale: 1,
        child: ExtendedImage.network(
          image.originalPhoto ? image.largeImageUrl : image.webformatUrl,
          mode: ExtendedImageMode.gesture,
          cache: true,
          initGestureConfigHandler: (state) => GestureConfig(
            minScale: .9,
            maxScale: 5,
            animationMaxScale: 5.5,
            animationMinScale: .9,
            speed: 1.0,
            initialScale: 1.0,
            inPageView: true,
          ),
        ),
      ),
    );
  }

  Widget _buildPopupMenu() => PopupMenuButton(
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              onTap: _handelDownload,
              child: const ListTile(
                title: Text("Download"),
                leading: Icon(Icons.download_rounded),
              ),
            ),
            PopupMenuItem(
              onTap: _handelViewOriginalPhoto,
              child: const ListTile(
                title: Text("Original Photo"),
                leading: Icon(Icons.four_k),
              ),
            ),
          ];
        },
      );
}
