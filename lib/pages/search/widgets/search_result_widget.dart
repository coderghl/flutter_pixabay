import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/image_type_entity.dart';

class SearchResultWidget extends StatefulWidget {
  const SearchResultWidget({
    super.key,
    required this.keyWords,
  });

  final String keyWords;

  @override
  State<SearchResultWidget> createState() => SearchResultWidgetState();
}

class SearchResultWidgetState extends State<SearchResultWidget> {
  @override
  Widget build(BuildContext context) {
    return ExtendedNestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [

      ],
      body: Container(),
    );
  }
}
