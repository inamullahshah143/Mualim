// To parse this JSON data, do
//
//     final reportModel = reportModelFromJson(jsonString);

import 'dart:convert';

ReportModel reportModelFromJson(String str) =>
    ReportModel.fromJson(json.decode(str));

String reportModelToJson(ReportModel data) => json.encode(data.toJson());

class ReportModel {
  ReportModel({
    required this.report,
  });

  List<Report> report;

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        report:
            List<Report>.from(json["report"].map((x) => Report.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "report": List<dynamic>.from(report.map((x) => x.toJson())),
      };
}

class Report {
  Report({
    required this.id,
    required this.teacherId,
    required this.subjectId,
    required this.chapterId,
    required this.score,
    required this.createdAt,
    required this.updatedAt,
    required this.chapter,
    required this.subject,
  });

  int id;
  int teacherId;
  int subjectId;
  int chapterId;
  String score;
  DateTime createdAt;
  DateTime updatedAt;
  Chapter chapter;
  Subject subject;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        teacherId: json["teacher_id"],
        subjectId: json["subject_id"],
        chapterId: json["chapter_id"],
        score: json["score"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        chapter: Chapter.fromJson(json["chapter"]),
        subject: Subject.fromJson(json["subject"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "teacher_id": teacherId,
        "subject_id": subjectId,
        "chapter_id": chapterId,
        "score": score,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "chapter": chapter.toJson(),
        "subject": subject.toJson(),
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
  });

  int id;
  String name;
  String description;
  int subjectId;
  DateTime createdAt;
  DateTime updatedAt;
  int chapterNo;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        subjectId: json["subject_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        chapterNo: json["chapter_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "subject_id": subjectId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "chapter_no": chapterNo,
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
  });

  int id;
  String name;
  String thumbnail;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        thumbnail: json["thumbnail"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "thumbnail": thumbnail,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
