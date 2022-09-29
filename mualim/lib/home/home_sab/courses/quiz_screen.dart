import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/constants/progress_bar.dart';
import 'package:mualim/constants/question_card.dart';
import 'package:mualim/controllers/question_controller.dart';

import '../../../constants/app_theme.dart';

class QuizScreen extends StatelessWidget {
  final List sampleData;
  final int subjectId;
  const QuizScreen({Key? key, required this.sampleData, required this.subjectId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController questionController =
        Get.put(QuestionController(sampleData: sampleData, subjectId:subjectId, context: context));
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: ProgressBar(),
              ),
              const SizedBox(height: kDefaultPadding),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Obx(
                  () => Text.rich(
                    TextSpan(
                      text:
                          "Question ${questionController.questionNumber.value}",
                      children: [
                        TextSpan(
                          text: "/${questionController.questions.length}",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(thickness: 1.5),
              const SizedBox(height: kDefaultPadding),
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: questionController.pageController,
                  onPageChanged: questionController.updateTheQnNum,
                  itemCount: questionController.questions.length,
                  itemBuilder: (context, index) => QuestionCard(
                    question: questionController.questions[index],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
