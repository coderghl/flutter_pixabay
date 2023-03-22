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

  late List<Widget> buttonList = [
    IconButton(
        onPressed: _handelDownload,
        icon: const Icon(Icons.file_download_rounded)),
    IconButton(
        onPressed: _handelViewOriginalPhoto,
        icon: const Icon(Icons.four_k_outlined)),
    IconButton(onPressed: () {}, icon: const Icon(Icons.image_outlined)),
  ];

  late List<Widget> labelList = const [
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

  void _handelPageChange(int index) {
    _index = index;
    setState(() {});
  }

  void _handelViewOriginalPhoto() {
    Navigator.pop(context);
    widget.data[_index].originalPhoto = true;
    setState(() {});
  }

  void _handelDownload() async {
    bool result =
        await api.downloadImage(url: widget.data[_index].largeImageUrl);
    Navigator.pop(context);
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
      onLongPress: _handelOnLongPress,
      onTap: _handelOnTap,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("${_index + 1}/${widget.data.length}"),
          actions: [],
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
      tag: image.id,
      child: InteractiveViewer(
        maxScale: 5,
        minScale: 1,
        child: Image.network(
          image.originalPhoto ? image.largeImageUrl : image.webformatUrl,
        ),
      ),
    );
  }
}
