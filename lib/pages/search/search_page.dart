import 'package:flutter/material.dart';
import 'package:flutter_pixabay/pages/search/widgets/search_history_widget.dart';
import 'package:flutter_pixabay/pages/search/widgets/search_result_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;
  bool isSearch = false;

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

  void _handelSearch() {
    if (_searchController.text.isEmpty) return;
    isSearch = true;
    setState(() {});
  }

  void _cancelSearch() {
    _searchController.clear();
    isSearch = false;
    setState(() {});
  }

  void _responseSearchTextFieldChange(value) {
    if (_searchController.text.isEmpty) {
      _cancelSearch();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: isSearch
            ? SearchResultWidget(
                keyWords: _searchController.text,
              )
            : SearchHistoryWidget(
                callback: (String value) {},
              ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: _buildSearchTextField(),
      actions: [
        TextButton(
          onPressed: _handelSearch,
          child: const Text("Search"),
        ),
      ],
    );
  }

  TextField _buildSearchTextField() {
    return TextField(
      controller: _searchController,
      onChanged: _responseSearchTextFieldChange,
      textInputAction: TextInputAction.search,
      onSubmitted: (v) => _handelSearch(),
      decoration: InputDecoration(
        hintText: "Search",
        suffixIcon: _searchController.text.isEmpty
            ? null
            : IconButton(
                onPressed: _cancelSearch,
                icon: const Icon(Icons.close_rounded),
              ),
        contentPadding: const EdgeInsets.only(
          top: 0,
          bottom: 0,
          left: 24,
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
