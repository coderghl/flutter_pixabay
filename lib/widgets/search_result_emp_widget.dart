import 'package:flutter/material.dart';

class SearchResultEmptyWidget extends StatelessWidget {
  const SearchResultEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 34,
            color: Theme.of(context).colorScheme.primary,
          ),
          Text("Not found Data")
        ],
      ),
    );
  }
}
