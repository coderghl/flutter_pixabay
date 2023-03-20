import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/image_entity.dart';
import 'package:flutter_pixabay/entity/image_type_entity.dart';
import 'package:flutter_pixabay/enum/image_order_enum.dart';
import 'package:flutter_pixabay/utils/network/api/image_api.dart';
import 'package:flutter_pixabay/skeleton/masonry_grid_skeleton.dart';
import 'package:flutter_pixabay/pages/image_details/image_details_page.dart';
import 'package:flutter_pixabay/widgets/network_error_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ImageTabPageWidget extends StatefulWidget {
  ImageTabPageWidget({
    super.key,
    required this.type,
  });

  final ImageTypeEntity type;

  @override
  State<ImageTabPageWidget> createState() => ImageTabPageWidgetState();
}

class ImageTabPageWidgetState extends State<ImageTabPageWidget> {
  late ImagePageEntity pageEntity;
  late ImageOrderEnum order;

  ImageApi api = ImageApi();
  bool dataIsReady = false;
  bool dataIsError = false;
  bool isLoadMore = false;

  int page = 1;

  String errorText = "";

  @override
  void initState() {
    getImage(ImageOrderEnum.foryou);
    super.initState();
  }

  void getImage(ImageOrderEnum order) {
    this.order = order;
    dataIsReady = false;
    dataIsError = false;
    page = 1;
    setState(() {});
    api.getImage(
      page: page,
      order: this.order,
      type: widget.type.type,
      successCallback: (data) {
        pageEntity = ImagePageEntity.fromJson(data);
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
    api.getImage(
      page: page,
      order: order,
      type: widget.type.type,
      successCallback: (data) {
        var newData = ImagePageEntity.fromJson(data);
        pageEntity.imageEntityList.addAll(newData.imageEntityList);
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
              reTry: () => getImage(order),
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
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 8,
      itemCount: pageEntity.imageEntityList.length + 1,
      itemBuilder: (context, index) {
        if (pageEntity.imageEntityList.length == index) {
          loadMore();
          return SizedBox();
        }
        var imageEntity = pageEntity.imageEntityList[index];
        return _buildItem(imageEntity, context, index);
      },
    );
  }

  Widget _buildItem(ImageEntity imageEntity, BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageDetailsPage(
                data: pageEntity.imageEntityList, index: index),
          ),
        );
      },
      child: Hero(
        tag: imageEntity.webformatUrl,
        child: Container(
          height: imageEntity.previewHeight.toDouble(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.secondary,
            image: DecorationImage(
              image: NetworkImage(imageEntity.webformatUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
