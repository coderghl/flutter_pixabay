import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/image_entity.dart';
import 'package:flutter_pixabay/enum/image_order_enum.dart';
import 'package:flutter_pixabay/enum/image_type_enum.dart';
import 'package:flutter_pixabay/pages/image_details/image_details_page.dart';
import 'package:flutter_pixabay/skeleton/skeleton_container.dart';
import 'package:flutter_pixabay/utils/network/api/image_api.dart';
import 'package:flutter_pixabay/widgets/network_error_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ImageList extends StatefulWidget {
  ImageList({
    Key? key,
    required this.type,
    this.order = ImageOrderEnum.foryou,
    this.categoryTitle = "",
    this.keyWords = "",
  }) : super(key: key);
  final ImageTypeEnum type;
  ImageOrderEnum order;
  String categoryTitle;
  String keyWords;

  @override
  State<ImageList> createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  late ImagePageEntity pageData;
  final ImageApi _api = ImageApi();

  int _page = 1;
  bool isHaveData = false;
  bool dataIsError = false;
  bool dataIsReady = false;
  bool isLoadMore = false;

  String errorText = "";

  @override
  void initState() {
    getImage();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ImageList oldWidget) {
    if (oldWidget.order != widget.order) {
      getImage();
    }
    super.didUpdateWidget(oldWidget);
  }

  void getImage() {
    dataIsError = false;
    dataIsReady = false;
    isHaveData = false;
    _page = 1;
    setState(() {});
    request();
  }

  void loadMore() {
    if (!isLoadMore) return;
    _page++;
    request();
  }

  void request() {
    _api.getImage(
      page: _page,
      order: widget.order,
      type: widget.type,
      keyWords: widget.keyWords,
      category: widget.categoryTitle,
      successCallback: (data) {
        if (isHaveData) {
          pageData.imageEntityList
              .addAll(ImagePageEntity.fromJson(data).imageEntityList);
        } else {
          pageData = ImagePageEntity.fromJson(data);
        }

        isHaveData = true;
        isLoadMore = false;
        dataIsReady = true;
        setState(() {});
      },
      errorCallback: (error) {
        dataIsError = true;
        isHaveData = false;
        errorText = error;
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
        child: dataIsError
            ? NetworkErrorWidget(
                errorText: errorText,
                reTry: () => getImage(),
              )
            : dataIsReady
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 8,
                      itemCount: pageData.imageEntityList.length + 1,
                      itemBuilder: (context, index) {
                        if (pageData.imageEntityList.length == index) {
                          isLoadMore = true;
                          loadMore();
                          return const SizedBox();
                        }
                        var data = pageData.imageEntityList[index];
                        return _buildItem(data, index);
                      },
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
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
          fit: BoxFit.cover,
          shape: BoxShape.rectangle,
          width: data.previewWidth.toDouble(),
          height: data.previewHeight.toDouble(),
          borderRadius: BorderRadius.circular(12),
          loadStateChanged: (state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                return SkeletonContainer(
                  size: Size(
                    data.previewWidth.toDouble(),
                    data.previewHeight.toDouble(),
                  ),
                );
              case LoadState.completed:
                break;
              case LoadState.failed:
                break;
            }
          },
        ),
      ),
    );
  }
}
