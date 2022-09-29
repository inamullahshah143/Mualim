// To parse this JSON data, do
//
//     final youtubeVideoDetailsModel = youtubeVideoDetailsModelFromJson(jsonString);

import 'dart:convert';

YoutubeVideoDetailsModel youtubeVideoDetailsModelFromJson(String str) =>
    YoutubeVideoDetailsModel.fromJson(json.decode(str));

String youtubeVideoDetailsModelToJson(YoutubeVideoDetailsModel data) =>
    json.encode(data.toJson());

class YoutubeVideoDetailsModel {
  YoutubeVideoDetailsModel({
    required this.title,
    required this.authorName,
    required this.authorUrl,
    required this.type,
    required this.height,
    required this.width,
    required this.version,
    required this.providerName,
    required this.providerUrl,
    required this.thumbnailHeight,
    required this.thumbnailWidth,
    required this.thumbnailUrl,
    required this.html,
  });

  String title;
  String authorName;
  String authorUrl;
  String type;
  int height;
  int width;
  String version;
  String providerName;
  String providerUrl;
  int thumbnailHeight;
  int thumbnailWidth;
  String thumbnailUrl;
  String html;

  factory YoutubeVideoDetailsModel.fromJson(Map<String, dynamic> json) =>
      YoutubeVideoDetailsModel(
        title: json["title"],
        authorName: json["author_name"],
        authorUrl: json["author_url"],
        type: json["type"],
        height: json["height"],
        width: json["width"],
        version: json["version"],
        providerName: json["provider_name"],
        providerUrl: json["provider_url"],
        thumbnailHeight: json["thumbnail_height"],
        thumbnailWidth: json["thumbnail_width"],
        thumbnailUrl: json["thumbnail_url"],
        html: json["html"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "author_name": authorName,
        "author_url": authorUrl,
        "type": type,
        "height": height,
        "width": width,
        "version": version,
        "provider_name": providerName,
        "provider_url": providerUrl,
        "thumbnail_height": thumbnailHeight,
        "thumbnail_width": thumbnailWidth,
        "thumbnail_url": thumbnailUrl,
        "html": html,
      };
}
