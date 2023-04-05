import 'dart:convert';

class VideoPageEntity {
  VideoPageEntity({
    required this.total,
    required this.totalHits,
    required this.hits,
  });

  int total;
  int totalHits;
  List<VideoEntity> hits;

  factory VideoPageEntity.fromRawJson(String str) =>
      VideoPageEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VideoPageEntity.fromJson(Map<String, dynamic> json) =>
      VideoPageEntity(
        total: json["total"],
        totalHits: json["totalHits"],
        hits: List<VideoEntity>.from(
            json["hits"].map((x) => VideoEntity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "totalHits": totalHits,
        "hits": List<VideoEntity>.from(hits.map((x) => x)),
      };
}

class VideoEntity {
  VideoEntity({
    required this.id,
    required this.pageUrl,
    required this.type,
    required this.tags,
    required this.duration,
    required this.pictureId,
    required this.videos,
    required this.views,
    required this.downloads,
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
  int duration;
  String pictureId;
  Videos videos;
  int views;
  int downloads;
  int likes;
  int comments;
  int userId;
  String user;
  String userImageUrl;

  factory VideoEntity.fromRawJson(String str) =>
      VideoEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VideoEntity.fromJson(Map<String, dynamic> json) => VideoEntity(
        id: json["id"],
        pageUrl: json["pageURL"],
        type: json["type"],
        tags: json["tags"],
        duration: json["duration"],
        pictureId: json["picture_id"],
        videos: Videos.fromJson(json["videos"]),
        views: json["views"],
        downloads: json["downloads"],
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
        "duration": duration,
        "picture_id": pictureId,
        "videos": videos.toJson(),
        "views": views,
        "downloads": downloads,
        "likes": likes,
        "comments": comments,
        "user_id": userId,
        "user": user,
        "userImageURL": userImageUrl,
      };
}

class Videos {
  Videos({
    required this.large,
    required this.medium,
    required this.small,
    required this.tiny,
  });

  Item large;
  Item medium;
  Item small;
  Item tiny;

  factory Videos.fromRawJson(String str) => Videos.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        large: Item.fromJson(json["large"]),
        medium: Item.fromJson(json["medium"]),
        small: Item.fromJson(json["small"]),
        tiny: Item.fromJson(json["tiny"]),
      );

  Map<String, dynamic> toJson() => {
        "large": large.toJson(),
        "medium": medium.toJson(),
        "small": small.toJson(),
        "tiny": tiny.toJson(),
      };
}

class Item {
  Item({
    required this.url,
    required this.width,
    required this.height,
    required this.size,
  });

  String url;
  int width;
  int height;
  int size;

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        url: json["url"],
        width: json["width"],
        height: json["height"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
        "size": size,
      };
}
