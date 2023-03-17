import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_pixabay/network/http/http.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class DownloadApi {
  Future<bool> downloadImage({
    required String url,
  }) async {
    bool result = false;
   await Http().download(
      url: url,
      options: Options(responseType: ResponseType.bytes),
      successCallback: (response) async {
        final value = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: url,
        );
        result = value['isSuccess'];
      },
      errorCallback: (error) {
        result = false;
      },
    );
    return result;
  }
}
