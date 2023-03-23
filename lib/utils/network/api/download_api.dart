import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class DownloadApi {
  Future<bool> downloadImage({
    required String url,
  }) async {
    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final value = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 100,
      name: url,
    );
    return value["isSuccess"];
  }

  Future<bool> downloadVideo({required String url}) async{
    var directory = await getTemporaryDirectory();
    String savePath = "${directory.path}/$url.mp4";
    await Dio().download(url, savePath, onReceiveProgress: (count, total) {
      print((count / total * 100).toStringAsFixed(0) + "%");
    });
    final result = await ImageGallerySaver.saveFile(savePath);
    print(result);
    return true;
  }
}
