import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/image_entity.dart';
import 'package:flutter_pixabay/enum/image_order_enum.dart';
import 'package:flutter_pixabay/enum/image_type_enum.dart';
import 'package:flutter_pixabay/pages/image_details/image_details_page.dart';
import 'package:flutter_pixabay/utils/network/api/image_api.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ImageList extends StatefulWidget {
  ImageList({
    Key? key,
    required this.type,
    this.category = "",
  }) : super(key: key);
  final ImageTypeEnum type;
  String category;

  @override
  State<ImageList> createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  late ImagePageEntity pageData;
  late ImageOrderEnum _order;

  final ImageApi _api = ImageApi();

  int _page = 1;
  bool _dataIsError = false;
  bool _dataIsReady = false;
  bool _isLoadMore = false;

  @override
  void initState() {
    getImage(ImageOrderEnum.foryou);
    super.initState();
  }

  void getImage(ImageOrderEnum order) {
    _order = order;
    _dataIsError = false;
    _dataIsReady = false;
    _page = 1;
    setState(() {});
    _api.getImage(
      page: _page,
      order: _order,
      type: widget.type,
      successCallback: (data) {
        pageData = ImagePageEntity.fromJson(data);
        _dataIsReady = true;
        setState(() {});
      },
      errorCallback: (error) {
        _dataIsError = true;
        setState(() {});
      },
    );
  }

  void loadMore() {
    if (_isLoadMore) return;
    _page++;
    _api.getImage(
      page: _page,
      order: _order,
      type: widget.type,
      successCallback: (data) {
        var newData = ImagePageEntity.fromJson(data);
        pageData.imageEntityList.addAll(newData.imageEntityList);
        _isLoadMore = false;
        setState(() {});
      },
      errorCallback: (error) {
        _dataIsError = true;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.background,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: _dataIsReady
            ? MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 8,
                itemCount: pageData.imageEntityList.length + 1,
                itemBuilder: (context, index) {
                  if (pageData.imageEntityList.length == index) {
                    loadMore();
                    return const SizedBox();
                  }
                  var data = pageData.imageEntityList[index];
                  return _buildItem(data, index);
                },
              )
            : null,
      ),
    );
  }

  Widget _buildItem(
    ImageEntity data,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageDetailsPage(
              data: pageData.imageEntityList,
              index: index,
            ),
          ),
        );
      },
      child: Hero(
        tag: data.webformatUrl,
        child: ExtendedImage.network(
          data.webformatUrl,
          shape: BoxShape.rectangle,
          width: data.previewWidth.toDouble(),
          borderRadius: BorderRadius.circular(12),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
