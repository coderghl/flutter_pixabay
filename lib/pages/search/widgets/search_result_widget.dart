import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/image_entity.dart';
import 'package:flutter_pixabay/entity/image_type_entity.dart';
import 'package:flutter_pixabay/pages/image_details/image_details_page.dart';
import 'package:flutter_pixabay/skeleton/masonry_grid_skeleton.dart';
import 'package:flutter_pixabay/utils/network/api/image_api.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchResultWidget extends StatefulWidget {
  const SearchResultWidget({
    super.key,
    required this.keyWords,
    required this.type,
  });
  final String keyWords;
  final ImageTypeEntity type;

  @override
  State<SearchResultWidget> createState() => SearchResultWidgetState();
}

class SearchResultWidgetState extends State<SearchResultWidget> {
  late ImagePageEntity pageEntity;

  ImageApi api = ImageApi();
  bool dataIsReady = false;
  bool dataIsError = false;
  bool isLoadMore = false;

  int page = 1;

  @override
  void initState() {
    _getImage();
    super.initState();
  }

  void _getImage() {
    dataIsReady = false;
    dataIsError = false;
    page = 1;
    api.getImage(
      page: page,
      type: widget.type.type,
      keyWords: widget.keyWords,
      successCallback: (data) {
        pageEntity = ImagePageEntity.fromJson(data);
        dataIsReady = true;
        setState(() {});
      },
      errorCallback: (error) {
        dataIsError = true;
        print("search Result error: $error");
      },
    );
  }

  void loadMore() {
    if (isLoadMore) return;
    page++;
    api.getImage(
      page: page,
      type: widget.type.type,
      keyWords: widget.keyWords,
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
    return dataIsError
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child:
                  dataIsReady ? _buildContent() : const MasonryGridSkeleton(),
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
              data: pageEntity.imageEntityList,
              index: index,
            ),
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
