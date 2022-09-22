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
