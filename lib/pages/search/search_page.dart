import 'package:flutter/material.dart';
import 'package:flutter_pixabay/pages/search/widgets/search_history_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;
  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SearchHistoryWidget(
          callback: (String value) {},
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: _buildSearchTextField(),
      actions: [
        TextButton(onPressed: () {}, child: const Text("Search")),
      ],
    );
  }

  TextField _buildSearchTextField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: "Search",
        contentPadding: const EdgeInsets.only(
          top: 0,
          bottom: 0,
          left: 24,
          right: 24,
        ),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }
}
