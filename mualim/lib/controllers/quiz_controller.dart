// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/model/quiz_model.dart';
import 'package:mualim/utils/api_utils.dart';

class QuizController extends GetxController with SingleGetTickerProviderMixin {
  List sample_data = [];
  Future<QuizModel?> registrationProcess(int chapterId, context) async {
    try {
      final response = await Dio().post(
        '${ApiUtils.baseUrl}/quiz',
        options: Options(
          headers: {"content-Type": "application/json"},
        ),
        data: {'chapter_id': chapterId},
      );
      if (response.statusCode == 200) {
        for (var element in response.data['quiz']) {
          sample_data.add(Quiz(id: element[''], question: element[''], details: element[''], chapterId: element[''], options: element[''], correctIndex: element['']));
        }
        return quizModelFromJson(jsonEncode(response.data));
      } else {
        return null;
      }
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(jsonDecode(e.response.toString())['error']),
        ),
      );

      return null;
    }
  }

  AnimationController? _animationController;
  Animation? _animation;
  Animation get animation => _animation!;

  PageController? _pageController;
  PageController get pageController => _pageController!;
  // final List<Quiz> _quiz = sample_data
  //     .map(
  //       (quiz) => Quiz(
  //         chapterId: quiz['chapter_id'],
  //         correctIndex: quiz['correctIndex'],
  //         details: quiz['details'],
  //         id: quiz['id'],
  //         options: quiz['options'],
  //         question: quiz['question'],
  //       ),
  //     )
  //     .toList();
  // List<Quiz> get quiz => _quiz;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  int? _correctAns;
  int get correctAns => _correctAns!;

  int? _selectedAns;
  int get selectedAns => _selectedAns!;
  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;
  @override
  void onInit() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!)
      ..addListener(() {
        update();
      });
    _animationController!.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }
  @override
  void onClose() {
    super.onClose();
    _animationController!.dispose();
    _pageController!.dispose();
  }

  void checkAns(Quiz quiz, int selectedIndex) {
    _isAnswered = true;
    _correctAns = quiz.correctIndex;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;
    _animationController!.stop();
    update();
    Future.delayed(const Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    // if (_questionNumber.value != _quiz.length) {
    //   _isAnswered = false;
    //   _pageController!.nextPage(
    //       duration: const Duration(milliseconds: 250), curve: Curves.ease);
    //   _animationController!.reset();
    //   _animationController!.forward().whenComplete(nextQuestion);
    // } else {
    //   // Get.to(ScoreScreen());
    // }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
