// To parse this JSON data, do
//
//     final quizModel = quizModelFromJson(jsonString);

import 'dart:convert';

QuizModel quizModelFromJson(String str) => QuizModel.fromJson(json.decode(str));

String quizModelToJson(QuizModel data) => json.encode(data.toJson());

class QuizModel {
  QuizModel({
    required this.quiz,
  });

  List<Quiz> quiz;

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        quiz: List<Quiz>.from(json["quiz"].map((x) => Quiz.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "quiz": List<dynamic>.from(quiz.map((x) => x.toJson())),
      };
}

class Quiz {
  Quiz({
    required this.id,
    required this.question,
    required this.details,
    required this.chapterId,
    required this.options,
    required this.correctIndex,
  });

  int id;
  String question;
  String details;
  int chapterId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String> options;
  int correctIndex;

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json["id"],
        question: json["question"],
        details: json["details"],
        chapterId: json["chapter_id"],
        options: List<String>.from(json["options"].map((x) => x)),
        correctIndex: json["correctIndex"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "details": details,
        "chapter_id": chapterId,
        "options": List<dynamic>.from(options.map((x) => x)),
        "correctIndex": correctIndex,
      };
}
