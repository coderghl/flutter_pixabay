import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/search_history_entity.dart';
import 'package:flutter_pixabay/utils/database/search_box.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "History",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (SearchBox().box.length != 0)
                IconButton(
                  onPressed: () {
                    SearchBox().removeAllKeyWord();
                    if (mounted) setState(() {});
                  },
                  icon: const Icon(Icons.delete_forever_rounded),
                )
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: SearchBox().box.listenable(),
              builder: (context, Box value, child) {
                if (value.isEmpty) {
                  return const SizedBox();
                } else {
                  return Wrap(
                    spacing: 16.0,
                    children: value.values
                        .toList()
                        .reversed
                        .map(
                          (e) => ActionChip(
                            label: Text(e.keyWord),
                            onPressed: () {
                              widget.callback.call(e.keyWord);
                            },
                          ),
                        )
                        .toList(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
