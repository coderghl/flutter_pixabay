import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/image_entity.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

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
  late PageController controller;
  int _index = 0; // currentPage

  late List<Widget> buttonList = [
    IconButton(onPressed: download, icon: Icon(Icons.file_download_rounded)),
    IconButton(onPressed: viewOriginalPhoto, icon: Icon(Icons.four_k_outlined)),
    IconButton(onPressed: () {}, icon: Icon(Icons.image_outlined)),
  ];

  late List<Widget> labelList = [
    Text("Download"),
    Text("Original photo"),
    Text("Set wallpaper"),
  ];

  @override
  void initState() {
    _index = widget.index;
    controller = PageController(initialPage: _index);
    _buildBottomSheet();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _buildBottomSheet() {
    buttonList = List.generate(
      buttonList.length,
      (index) => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 40),
        child: Column(
          children: [
            buttonList[index],
            labelList[index],
          ],
        ),
      ),
    );
  }

  void _handelOnTap() {
    Navigator.pop(context);
  }

  void _handelOnLongPress() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buttonList,
          ),
        );
      },
    );
  }

  /// view original photo
  void viewOriginalPhoto() {
    Navigator.pop(context);
    widget.data[_index].originalPhoto = true;
    setState(() {});
  }

  /// download
  void download() async {
    var response = await Dio().get(widget.data[_index].largeImageUrl,
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 60,
      name: widget.data[_index].largeImageUrl,
    );
    if (result["isSuccess"]) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Download success")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _handelOnLongPress,
      onTap: _handelOnTap,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              PageView.builder(
                pageSnapping: true,
                controller: controller,
                itemCount: widget.data.length,
                onPageChanged: (index) {
                  _index = index;
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  var image = widget.data[index];
                  return Hero(
                    tag: image.webformatUrl,
                    child: InteractiveViewer(
                      maxScale: 5,
                      minScale: 1,
                      child: Image.network(
                        image.originalPhoto
                            ? image.largeImageUrl
                            : image.webformatUrl,
                      ),
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment(0, -1),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("${_index + 1}/${widget.data.length}"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
