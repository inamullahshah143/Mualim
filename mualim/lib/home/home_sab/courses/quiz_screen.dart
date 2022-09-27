import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/constants/progress_bar.dart';
import 'package:mualim/constants/question_card.dart';
import 'package:mualim/controllers/question_controller.dart';

import '../../../constants/app_theme.dart';

class QuizScreen extends StatelessWidget {
  final List sampleData; 
  const QuizScreen({Key? key, required this.sampleData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController questionController = Get.put(QuestionController(sampleData:sampleData));
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          MaterialButton(
            onPressed: questionController.nextQuestion,
            child: const Text("Skip"),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: ProgressBar(),
            ),
            const SizedBox(height: kDefaultPadding),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Obx(
                () => Text.rich(
                  TextSpan(
                    text: "Question ${questionController.questionNumber.value}",
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
    );
  }
}
