// ignore_for_file: deprecated_member_use, import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/constants/app_theme.dart';
import 'package:mualim/controllers/subject_controller.dart';
import 'package:mualim/home/dashboard.dart';
import 'package:mualim/model/question_model.dart';

// We use get package for our state management

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  int? subjectId;
  List? sampleData;
  final BuildContext context;
  QuestionController({this.sampleData, this.subjectId, required this.context});
  // Lets animated our progress bar

  AnimationController? _animationController;
  Animation? _animation;
  // so that we can access our animation outside
  Animation get animation => _animation!;

  PageController? _pageController;
  PageController get pageController => _pageController!;
  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  int? _correctAns;
  int get correctAns => _correctAns!;

  int? _selectedAns;
  int get selectedAns => _selectedAns!;

  // for more about obs please check documentation
  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;
  List<Question>? _questions = [];
  List<Question> get questions => _questions!;

  final subjectController = Get.put(SubjectController());
  @override
  void onInit() {
    _questions = sampleData!
        .map(
          (question) => Question(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index'],
          ),
        )
        .toList();
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

  void checkAns(Question question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;
    _animationController!.stop();
    update();
    Future.delayed(const Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions!.length) {
      _isAnswered = false;
      _pageController!.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
      _animationController!.reset();
      _animationController!.forward().whenComplete(nextQuestion);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text('Your score is:'),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    '${_numOfCorrectAns * 10}/${questions.length * 10}',
                    style: const TextStyle(
                      color: AppTheme.appThemeColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if ((_numOfCorrectAns / questions.length) * 100 >= 50)
                  const Text(
                      'Congratulations you are passed this module and you are moved on next module'),
                if ((_numOfCorrectAns / questions.length) * 100 < 50)
                  const Text('We are Sorry! you failed this module'),
              ],
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  processLoading(context);
                  subjectController.updateChapterIndex(
                      subjectId!, context, _numOfCorrectAns, questions.length);
                  Get.offAll(const Dashboard());
                },
                child: const Text('Proceed'),
              ),
            ],
          );
        },
      );
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

}
