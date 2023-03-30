import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/video_entity.dart';
import 'package:flutter_pixabay/enum/video_order_enum.dart';
import 'package:flutter_pixabay/enum/video_type_enum.dart';
import 'package:flutter_pixabay/pages/video_details/video_details_page.dart';
import 'package:flutter_pixabay/skeleton/skeleton_container.dart';
import 'package:flutter_pixabay/utils/constants.dart';
import 'package:flutter_pixabay/utils/network/api/video_api.dart';
import 'package:flutter_pixabay/widgets/network_error_widget.dart';

class VideoList extends StatefulWidget {
  VideoList({
    Key? key,
    required this.type,
    this.order = VideoOrderEnum.popular,
    this.categoryTitle = "",
    this.keyWords = "",
  }) : super(key: key);

  final VideoTypeEnum type;
  final VideoOrderEnum order;
  String categoryTitle;
  String keyWords;

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late VideoPageEntity pageData;

  VideoApi api = VideoApi();

  int _page = 1;
  int _totalPages = 0;
  bool dataIsReady = false;
  bool dataIsError = false;
  bool isLoadMore = false;
  bool isHaveData = false;
  bool searchResultEqualZero = false;
  String errorText = "";

  @override
  void initState() {
    getVideo();
    super.initState();
  }

  void getVideo() {
    dataIsReady = false;
    dataIsError = false;
    isHaveData = false;
    searchResultEqualZero = false;
    _page = 1;
    setState(() {});
    request();
  }

  void loadMore() async {
    if (!isLoadMore) return;
    if (_page < _totalPages) {
      _page++;
      await request();
    }
  }

  Future<void> request() async {
    api.getVideo(
      page: _page,
      order: widget.order,
      keyWords: widget.keyWords,
      category: widget.categoryTitle,
      type: widget.type,
      successCallback: (data) {
        if (isHaveData) {
          pageData.hits.addAll(VideoPageEntity.fromJson(data).hits);
        } else {
          pageData = VideoPageEntity.fromJson(data);
        }

        _totalPages = (pageData.total + kPerPage - 1) ~/ kPerPage;

        if (_totalPages == 0) {
          searchResultEqualZero = true;
        }

        isHaveData = true;
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
  void didUpdateWidget(covariant VideoList oldWidget) {
    if (oldWidget.order != widget.order) {
      getVideo();
    }
    super.didUpdateWidget(oldWidget);
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
                reTry: () => getVideo(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: dataIsReady
                      ? searchResultEqualZero
                          ? const Center(
                              child: Text("No results found for your search"),
                            )
                          : _buildContent()
                      : const CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }

  Widget _buildContent() {
    return ListView.builder(
      itemCount: pageData.hits.length + 1,
      itemBuilder: (context, index) {
        if (pageData.hits.length == index) {
          isLoadMore = true;
          loadMore();
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        var item = pageData.hits[index];
        return _buildItem(item);
      },
    );
  }

  Widget _buildItem(VideoEntity item) {
    return GestureDetector(
      onTap: () => _handelOnTap(item),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: ExtendedImage.network(
          "https://i.vimeocdn.com/video/${item.pictureId}_960x540.jpg",
          height: 250,
          fit: BoxFit.cover,
          width: double.infinity,
          shape: BoxShape.rectangle,
          loadStateChanged: (state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                return const SkeletonContainer(
                  size: Size(double.infinity, 250),
                );
              case LoadState.completed:
                break;
              case LoadState.failed:
                break;
            }
          },
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _handelOnTap(VideoEntity data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoDetailsPage(data: data),
      ),
    );
  }
}
