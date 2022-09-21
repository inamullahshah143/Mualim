import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/constants/custom_courses_cards.dart';
import 'package:mualim/controllers/subject_controller.dart';
import 'package:mualim/model/subject_model.dart';
import 'package:mualim/utils/api_utils.dart';

final subjectController = Get.put(SubjectController());

class AllCourses extends StatefulWidget {
  const AllCourses({Key? key}) : super(key: key);

  @override
  State<AllCourses> createState() => _AllCoursesState();
}

class _AllCoursesState extends State<AllCourses> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SubjectModel?>(
      stream: subjectController.loadSubjects(context),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Text('Loading....');
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final data = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: data!.subject.length,
                itemBuilder: ((context, index) {
                  return CustomCoursesCards(
                    subjectId: data.subject[index].id,
                    lessons: data.subject[index].chapter.length,
                    thumbnail:
                        ApiUtils.storageUrl + data.subject[index].thumbnail,
                    title: data.subject[index].name,
                    subtitle: data.subject[index].description,
                  );
                }),
              );
            }
        }
      },
    );
  }
}
