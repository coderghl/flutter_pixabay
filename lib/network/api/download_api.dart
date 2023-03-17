import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class DownloadApi {
  Future<bool> downloadImage({
    required String url,
  }) async {
    var response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));
    final value = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 60,
      name: url,
    );
    return value["isSuccess"];
  }
}
