// To parse this JSON data, do
//
//     final currentStatusModel = currentStatusModelFromJson(jsonString);

import 'dart:convert';

CurrentStatusModel currentStatusModelFromJson(String str) =>
    CurrentStatusModel.fromJson(json.decode(str));

String currentStatusModelToJson(CurrentStatusModel data) =>
    json.encode(data.toJson());

class CurrentStatusModel {
  CurrentStatusModel({
    required this.satus,
  });

  Satus satus;

  factory CurrentStatusModel.fromJson(Map<String, dynamic> json) =>
      CurrentStatusModel(
        satus: Satus.fromJson(json["satus"]),
      );

  Map<String, dynamic> toJson() => {
        "satus": satus.toJson(),
      };
}

class Satus {
  Satus({
    required this.id,
    required this.teacherId,
    required this.subjectId,
    required this.chapterId,
    required this.chapterNo,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int teacherId;
  int subjectId;
  int chapterId;
  String chapterNo;
  DateTime createdAt;
  DateTime updatedAt;

  factory Satus.fromJson(Map<String, dynamic> json) => Satus(
        id: json["id"],
        teacherId: json["teacher_id"],
        subjectId: json["subject_id"],
        chapterId: json["chapter_id"],
        chapterNo: json["chapter_no"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "teacher_id": teacherId,
        "subject_id": subjectId,
        "chapter_id": chapterId,
        "chapter_no": chapterNo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
