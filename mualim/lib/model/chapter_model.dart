// To parse this JSON data, do
//
//     final chapterModel = chapterModelFromJson(jsonString);

import 'dart:convert';

ChapterModel chapterModelFromJson(String str) =>
    ChapterModel.fromJson(json.decode(str));

String chapterModelToJson(ChapterModel data) => json.encode(data.toJson());

class ChapterModel {
  ChapterModel({
    required this.chapter,
  });

  Chapter chapter;

  factory ChapterModel.fromJson(Map<String, dynamic> json) => ChapterModel(
        chapter: Chapter.fromJson(json["chapter"]),
      );

  Map<String, dynamic> toJson() => {
        "chapter": chapter.toJson(),
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
    required this.videos,
    required this.files,
    required this.quizzes,
  });

  int id;
  String name;
  String description;
  int subjectId;
  DateTime createdAt;
  DateTime updatedAt;
  int chapterNo;
  List<String> videos;
  List<String> files;
  List<Quiz> quizzes;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        subjectId: json["subject_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        chapterNo: json["chapter_no"],
        videos: List<String>.from(json["videos"].map((x) => x)),
        files: List<String>.from(json["files"].map((x) => x)),
        quizzes: List<Quiz>.from(json["quizzes"].map((x) => Quiz.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "subject_id": subjectId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "chapter_no": chapterNo,
        "videos": List<dynamic>.from(videos.map((x) => x)),
        "files": List<dynamic>.from(files.map((x) => x)),
        "quizzes": List<dynamic>.from(quizzes.map((x) => x.toJson())),
      };
}

class Quiz {
  Quiz({
    required this.id,
    required this.question,
    required this.details,
    required this.chapterId,
    required this.createdAt,
    required this.updatedAt,
    required this.options,
    required this.correctIndex,
  });

  int id;
  String question;
  String details;
  int chapterId;
  DateTime createdAt;
  DateTime updatedAt;
  List<String> options;
  int correctIndex;

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json["id"],
        question: json["question"],
        details: json["details"],
        chapterId: json["chapter_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        options: List<String>.from(json["options"].map((x) => x)),
        correctIndex: json["correctIndex"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "details": details,
        "chapter_id": chapterId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "options": List<dynamic>.from(options.map((x) => x)),
        "correctIndex": correctIndex,
      };
}
