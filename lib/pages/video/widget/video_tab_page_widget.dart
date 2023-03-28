import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/video_entity.dart';
import 'package:flutter_pixabay/entity/video_type_entity.dart';
import 'package:flutter_pixabay/enum/video_order_enum.dart';
import 'package:flutter_pixabay/pages/video_details/video_details_page.dart';
import 'package:flutter_pixabay/skeleton/skeleton_container.dart';
import 'package:flutter_pixabay/utils/network/api/video_api.dart';
import 'package:flutter_pixabay/widgets/network_error_widget.dart';

class VideoTabPageWidget extends StatefulWidget {
  const VideoTabPageWidget({
    Key? key,
    required this.type,
  }) : super(key: key);
  final VideoTypeEntity type;

  @override
  State<VideoTabPageWidget> createState() => VideoTabPageWidgetState();
}

class VideoTabPageWidgetState extends State<VideoTabPageWidget> {
  late VideoOrderEnum order;
  late VideoPageEntity pageEntity;

  VideoApi api = VideoApi();
  bool dataIsReady = false;
  bool dataIsError = false;
  bool isLoadMore = false;

  int page = 1;

  String errorText = "";

  @override
  void initState() {
    getVideo(VideoOrderEnum.popular);
    super.initState();
  }

  void getVideo(VideoOrderEnum order) {
    this.order = order;
    dataIsReady = false;
    dataIsError = false;
    page = 1;
    setState(() {});
    api.getVideo(
      page: page,
      order: this.order,
      type: widget.type.type,
      successCallback: (data) {
        pageEntity = VideoPageEntity.fromJson(data);
        dataIsReady = true;
        setState(() {});
      },
      errorCallback: (error) {
        dataIsError = true;
        errorText = error;
        setState(() {});
      },
    );
  }

  void loadMore() {
    if (isLoadMore) return;
    page++;
    api.getVideo(
      page: page,
      order: order,
      type: widget.type.type,
      successCallback: (data) {
        var newData = VideoPageEntity.fromJson(data);
        pageEntity.hits.addAll(newData.hits);
        isLoadMore = false;
        setState(() {});
      },
      errorCallback: (error) {
        dataIsError = true;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: dataIsError
          ? NetworkErrorWidget(
              errorText: errorText,
              reTry: () => getVideo(order),
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
    );
  }

  Widget _buildContent() {
    return ListView.builder(
      itemCount: pageEntity.hits.length + 1,
      itemBuilder: (context, index) {
        if (pageEntity.hits.length == index) {
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
