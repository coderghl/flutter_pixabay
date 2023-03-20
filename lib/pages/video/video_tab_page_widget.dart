import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/video_entity.dart';
import 'package:flutter_pixabay/entity/video_type_entity.dart';
import 'package:flutter_pixabay/enum/video_order_enum.dart';
import 'package:flutter_pixabay/skeleton/masonry_grid_skeleton.dart';
import 'package:flutter_pixabay/utils/constants.dart';
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
        print(data);
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
                child:
                    dataIsReady ? _buildContent() : const MasonryGridSkeleton(),
              ),
            ),
    );
  }

  Widget _buildContent() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 200,
        mainAxisSpacing: 16,
        crossAxisSpacing: 8,
      ),
      itemCount: pageEntity.hits.length + 1,
      itemBuilder: (context, index) {
        if (pageEntity.hits.length == index) {
          loadMore();
          return SizedBox();
        }
        var item = pageEntity.hits[index];
        return Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(
                  "https://i.vimeocdn.com/video/${item.pictureId}_640x360.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black.withOpacity(.5)),
              ),
              Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.play_circle_outline_rounded,
                  size: 48,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        );
      },

    );
  }
}
