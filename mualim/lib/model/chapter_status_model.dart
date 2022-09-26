// To parse this JSON data, do
//
//     final chapterStatusModel = chapterStatusModelFromJson(jsonString);

import 'dart:convert';

ChapterStatusModel chapterStatusModelFromJson(String str) =>
    ChapterStatusModel.fromJson(json.decode(str));

String chapterStatusModelToJson(ChapterStatusModel data) =>
    json.encode(data.toJson());

class ChapterStatusModel {
  ChapterStatusModel({
    required this.satus,
    required this.data,
  });

  String satus;
  Data data;

  factory ChapterStatusModel.fromJson(Map<String, dynamic> json) =>
      ChapterStatusModel(
        satus: json["satus"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "satus": satus,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.teacherId,
    required this.subjectId,
    required this.chapterId,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int teacherId;
  String subjectId;
  String chapterId;
  String position;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        teacherId: json["teacher_id"],
        subjectId: json["subject_id"],
        chapterId: json["chapter_id"],
        position: json["position"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "teacher_id": teacherId,
        "subject_id": subjectId,
        "chapter_id": chapterId,
        "position": position,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
