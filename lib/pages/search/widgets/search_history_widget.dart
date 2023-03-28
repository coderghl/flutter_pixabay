import 'package:flutter/material.dart';

class SearchHistoryWidget extends StatefulWidget {
  const SearchHistoryWidget({super.key, required this.callback});

  final void Function(String value) callback;

  @override
  State<SearchHistoryWidget> createState() => _SearchHistoryWidgetState();
}

class _SearchHistoryWidgetState extends State<SearchHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "History",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
