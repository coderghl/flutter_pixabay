import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/image_entity.dart';
import 'package:flutter_pixabay/entity/image_type_entity.dart';
import 'package:flutter_pixabay/network/api/image_api.dart';
import 'package:flutter_pixabay/network/base/service_manager.dart';
import 'package:flutter_pixabay/network/service/image_service.dart';
import 'package:flutter_pixabay/pages/home/skeleton/home_tab_page_skeleton.dart';
import 'package:flutter_pixabay/pages/image_details/image_details_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTabPageWidget extends StatefulWidget {
  const HomeTabPageWidget({
    super.key,
    required this.type,
  });

  final ImageTypeEntity type;

  @override
  State<HomeTabPageWidget> createState() => _HomeTabPageWidgetState();
}

class _HomeTabPageWidgetState extends State<HomeTabPageWidget> {
  ImageApi api = ImageApi();

  bool dataIsReady = false;
  late ImagePageEntity pageEntity;

  @override
  void initState() {
    initApi();
    getImage();
    super.initState();
  }

  void initApi() {
    ServiceManager().registerService(ImageService());
    api.mediaType = widget.type.type;
    api.initImageTypeUrl();
  }

  void getImage() {
    api.request(
      successCallback: (data) {
        pageEntity = ImagePageEntity.fromJson(data);
        dataIsReady = true;
        setState(() {});
      },
      errorCallback: (error) {
        print("error: $error");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: dataIsReady ? _buildContent() : const HomeTabPageSkeleton(),
      ),
    );
  }

  MasonryGridView _buildContent() {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 8,
      itemCount: pageEntity.imageEntityList.length,
      itemBuilder: (context, index) {
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
                    data: pageEntity.imageEntityList, index: index)));
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

  void _handelTab() {}
}
