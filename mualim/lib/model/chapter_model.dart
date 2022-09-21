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
    required this.content,
    required this.quiz,
  });

  int id;
  String name;
  String description;
  int subjectId;
  DateTime createdAt;
  DateTime updatedAt;
  List<Content> content;
  List<Quiz> quiz;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        subjectId: json["subject_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
        quiz: List<Quiz>.from(json["quiz"].map((x) => Quiz.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "subject_id": subjectId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "quiz": List<dynamic>.from(quiz.map((x) => x.toJson())),
      };
}

class Content {
  Content({
    required this.id,
    required this.title,
    required this.note,
    required this.video,
    required this.file,
    required this.chapterId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String title;
  String note;
  String video;
  String file;
  int chapterId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        title: json["title"],
        note: json["note"],
        video: json["video"],
        file: json["file"],
        chapterId: json["chapter_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "note": note,
        "video": video,
        "file": file,
        "chapter_id": chapterId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Quiz {
  Quiz({
    required this.id,
    required this.question,
    required this.details,
    required this.chapterId,
    required this.firstOption,
    required this.secondOption,
    required this.thirdOption,
    required this.fourthOption,
    required this.correct,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String question;
  String details;
  int chapterId;
  String firstOption;
  String secondOption;
  String thirdOption;
  String fourthOption;
  int correct;
  DateTime createdAt;
  DateTime updatedAt;

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json["id"],
        question: json["question"],
        details: json["details"],
        chapterId: json["chapter_id"],
        firstOption: json["first_option"],
        secondOption: json["second_option"],
        thirdOption: json["third_option"],
        fourthOption: json["fourth_option"],
        correct: json["correct"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "details": details,
        "chapter_id": chapterId,
        "first_option": firstOption,
        "second_option": secondOption,
        "third_option": thirdOption,
        "fourth_option": fourthOption,
        "correct": correct,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
