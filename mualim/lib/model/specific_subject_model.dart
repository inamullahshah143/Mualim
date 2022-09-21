// To parse this JSON data, do
//
//     final specificSubjectModel = specificSubjectModelFromJson(jsonString);

import 'dart:convert';

SpecificSubjectModel specificSubjectModelFromJson(String str) =>
    SpecificSubjectModel.fromJson(json.decode(str));

String specificSubjectModelToJson(SpecificSubjectModel data) =>
    json.encode(data.toJson());

class SpecificSubjectModel {
  SpecificSubjectModel({
    required this.subject,
  });

  Subject subject;

  factory SpecificSubjectModel.fromJson(Map<String, dynamic> json) =>
      SpecificSubjectModel(
        subject: Subject.fromJson(json["subject"]),
      );

  Map<String, dynamic> toJson() => {
        "subject": subject.toJson(),
      };
}

class Subject {
  Subject({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.chapter,
  });

  int id;
  String name;
  String thumbnail;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  List<Chapter> chapter;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        thumbnail: json["thumbnail"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        chapter:
            List<Chapter>.from(json["chapter"].map((x) => Chapter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "thumbnail": thumbnail,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
  });

  int id;
  String name;
  String description;
  int subjectId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        subjectId: json["subject_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "subject_id": subjectId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
