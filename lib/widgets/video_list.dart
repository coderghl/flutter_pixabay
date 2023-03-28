import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/video_entity.dart';
import 'package:flutter_pixabay/enum/video_order_enum.dart';
import 'package:flutter_pixabay/enum/video_type_enum.dart';
import 'package:flutter_pixabay/pages/video_details/video_details_page.dart';
import 'package:flutter_pixabay/skeleton/skeleton_container.dart';
import 'package:flutter_pixabay/utils/network/api/video_api.dart';
import 'package:flutter_pixabay/widgets/network_error_widget.dart';

class VideoList extends StatefulWidget {
  VideoList({
    Key? key,
    required this.type,
    this.order = VideoOrderEnum.popular,
    this.categoryTitle = "",
  }) : super(key: key);

  final VideoTypeEnum type;
  final VideoOrderEnum order;
  String categoryTitle;

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late VideoPageEntity pageEntity;

  VideoApi api = VideoApi();
  bool dataIsReady = false;
  bool dataIsError = false;
  bool isLoadMore = false;
  bool isHaveData = false;

  int page = 1;

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
    page = 1;
    setState(() {});
    request();
  }

  void loadMore() {
    if (!isLoadMore) return;
    page++;
    request();
  }

  void request() {
    api.getVideo(
      page: page,
      order: widget.order,
      category: widget.categoryTitle,
      type: widget.type,
      successCallback: (data) {
        if (isHaveData) {
          pageEntity.hits.addAll(VideoPageEntity.fromJson(data).hits);
        } else {
          pageEntity = VideoPageEntity.fromJson(data);
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
                      ? _buildContent()
                      : const CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }

  Widget _buildContent() {
    return ListView.builder(
      itemCount: pageEntity.hits.length + 1,
      itemBuilder: (context, index) {
        if (pageEntity.hits.length == index) {
          isLoadMore = true;
          loadMore();
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        var item = pageEntity.hits[index];
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
