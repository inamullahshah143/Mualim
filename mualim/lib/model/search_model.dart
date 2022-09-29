// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    required this.chapter,
  });

  List<Chapter> chapter;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        chapter:
            List<Chapter>.from(json["chapter"].map((x) => Chapter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "chapter": List<dynamic>.from(chapter.map((x) => x.toJson())),
      };
}

class Chapter {
  Chapter({
    required this.id,
    required this.name,
    required this.description,
    required this.subjectId,
    required this.createdAt,
    required this.updatedAt,
    required this.chapterNo,
    required this.content,
  });

  int id;
  String name;
  String description;
  int subjectId;
  DateTime createdAt;
  DateTime updatedAt;
  int chapterNo;
  List<Content> content;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        subjectId: json["subject_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        chapterNo: json["chapter_no"],
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "subject_id": subjectId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "chapter_no": chapterNo,
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
      };
}

class Content {
  Content({
    required this.id,
    required this.video,
    required this.file,
    required this.chapterId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String video;
  String file;
  int chapterId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        video: json["video"].toString(),
        file: json["file"].toString(),
        chapterId: json["chapter_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video": video,
        "file": file,
        "chapter_id": chapterId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
