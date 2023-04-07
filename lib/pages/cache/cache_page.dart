import 'package:flutter/material.dart';
import 'package:flutter_pixabay/utils/database/cache_box.dart';
import 'package:flutter_pixabay/utils/database/search_box.dart';
import 'package:flutter_pixabay/utils/extended.dart';
import 'package:flutter_pixabay/widgets/list_tile_m3_widget.dart';

class CachePage extends StatefulWidget {
  const CachePage({super.key});

  @override
  State<CachePage> createState() => _CachePageState();
}

class _CachePageState extends State<CachePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cache"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListTileM3Widget(
          onTap: () async {
            var length = await CacheBox().clearCache();
            context.showMessage("Delete $length caches");
          },
          trailing: Icon(Icons.delete_forever),
          title: Text("Clear cache"),
        ),
      ),
    );
  }
}
