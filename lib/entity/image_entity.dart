import 'dart:convert';

class ImagePageEntity {
  ImagePageEntity({
    required this.total,
    required this.totalHits,
    required this.imageEntityList,
  });

  int total;
  int totalHits;
  List<ImageEntity> imageEntityList;

  factory ImagePageEntity.fromRawJson(String str) =>
      ImagePageEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImagePageEntity.fromJson(Map<String, dynamic> json) =>
      ImagePageEntity(
        total: json["total"],
        totalHits: json["totalHits"],
        imageEntityList: List<ImageEntity>.from(
            json["hits"].map((x) => ImageEntity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "totalHits": totalHits,
        "hits":
            List<dynamic>.from(imageEntityList.map((x) => x.toJson())),
      };
}

class ImageEntity {
  ImageEntity({
    required this.id,
    required this.pageUrl,
    required this.type,
    required this.tags,
    required this.previewUrl,
    required this.previewWidth,
    required this.previewHeight,
    required this.webformatUrl,
    required this.webformatWidth,
    required this.webformatHeight,
    required this.largeImageUrl,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageSize,
    required this.views,
    required this.downloads,
    required this.collections,
    required this.likes,
    required this.comments,
    required this.userId,
    required this.user,
    required this.userImageUrl,
  });

  int id;
  String pageUrl;
  String type;
  String tags;
  String previewUrl;
  int previewWidth;
  int previewHeight;
  String webformatUrl;
  int webformatWidth;
  int webformatHeight;
  String largeImageUrl;
  int imageWidth;
  int imageHeight;
  int imageSize;
  int views;
  int downloads;
  int collections;
  int likes;
  int comments;
  int userId;
  String user;
  String userImageUrl;

  // Custom data
  bool originalPhoto = false;

  factory ImageEntity.fromRawJson(String str) =>
      ImageEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageEntity.fromJson(Map<String, dynamic> json) => ImageEntity(
        id: json["id"],
        pageUrl: json["pageURL"],
        type: json["type"],
        tags: json["tags"],
        previewUrl: json["previewURL"],
        previewWidth: json["previewWidth"],
        previewHeight: json["previewHeight"],
        webformatUrl: json["webformatURL"],
        webformatWidth: json["webformatWidth"],
        webformatHeight: json["webformatHeight"],
        largeImageUrl: json["largeImageURL"],
        imageWidth: json["imageWidth"],
        imageHeight: json["imageHeight"],
        imageSize: json["imageSize"],
        views: json["views"],
        downloads: json["downloads"],
        collections: json["collections"],
        likes: json["likes"],
        comments: json["comments"],
        userId: json["user_id"],
        user: json["user"],
        userImageUrl: json["userImageURL"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pageURL": pageUrl,
        "type": type,
        "tags": tags,
        "previewURL": previewUrl,
        "previewWidth": previewWidth,
        "previewHeight": previewHeight,
        "webformatURL": webformatUrl,
        "webformatWidth": webformatWidth,
        "webformatHeight": webformatHeight,
        "largeImageURL": largeImageUrl,
        "imageWidth": imageWidth,
        "imageHeight": imageHeight,
        "imageSize": imageSize,
        "views": views,
        "downloads": downloads,
        "collections": collections,
        "likes": likes,
        "comments": comments,
        "user_id": userId,
        "user": user,
        "userImageURL": userImageUrl,
      };
}
