import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/model/subject_model.dart';

import '../../controllers/subject_controller.dart';

final subjectController = Get.put(SubjectController());

class SavedCourses extends StatelessWidget {
  const SavedCourses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SubjectModel?>(
      stream: subjectController.loadSubjects(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Text('Loading....');
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Container(
                color: Colors.white,
                child: Center(
                  child: Text('${snapshot.data!.subject[0].name.toString()} '), 
                ),
              );
            }
        }
      },
    );
  }
}
