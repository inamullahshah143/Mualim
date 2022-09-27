import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/question_controller.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController qnController = Get.put(QuestionController());
    return Scaffold(
      body: Column(
        children: [
          const Spacer(flex: 3),
          const Text(
            "Score",
          ),
          const Spacer(),
          Text(
            "${qnController.correctAns * 10}/${qnController.questions.length * 10}",
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
