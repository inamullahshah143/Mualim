
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/controllers/question_controller.dart';
import 'package:auto_direction/auto_direction.dart';

class Option extends StatelessWidget {
  const Option({
    Key? key,
    required this.text,
    required this.index,
    required this.press,
  }) : super(key: key);
  final String text;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
      init: QuestionController(context: context),
      builder: (qnController) {
        Color getTheRightColor() {
          if (qnController.isAnswered) {
            if (index == qnController.selectedAns) {
              return Colors.green;
            }
          }
          return Colors.grey;
        }

        return InkWell(
          onTap: press,
          child: AutoDirection(
            text:text,
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Text(
                "${index + 1}",
                style: TextStyle(color: getTheRightColor(), fontSize: 16),
              ),
              title: Text(
                text,
                style: TextStyle(color: getTheRightColor(), fontSize: 16),
              ),
              trailing: Container(
                height: 26,
                width: 26,
                decoration: BoxDecoration(
                  color: getTheRightColor() == Colors.grey
                      ? Colors.transparent
                      : getTheRightColor(),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: getTheRightColor()),
                ),
                child: getTheRightColor() == Colors.grey
                    ? null
                    : const Icon(Icons.done, size: 16),
              ),
            ),
          ),
        );
      },
    );
  }
}
