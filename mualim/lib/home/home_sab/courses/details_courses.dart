import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/constants/app_theme.dart';
import 'package:mualim/controllers/subject_controller.dart';
import 'package:mualim/home/home_sab/courses/lesson_screen.dart';
import 'package:mualim/model/specific_subject_model.dart';

final subjectController = Get.put(SubjectController());

class DetailedCourse extends StatefulWidget {
  final int subjectId;
  final String title;
  final String subtitle;
  final int lessons;
  final String thumbnail;
  const DetailedCourse({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.lessons,
    required this.thumbnail,
    required this.subjectId,
  }) : super(key: key);

  @override
  State<DetailedCourse> createState() => _DetailedCourseState();
}

class _DetailedCourseState extends State<DetailedCourse> {
  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      backgroundColor: AppTheme.placeholder,
      alwaysShowLeadingAndAction: true,
      headerExpandedHeight: 0.4,
      appBarColor: AppTheme.appThemeColor,
      title: Text(widget.title),
      headerWidget: headerWidget(context),
      body: [
        listView(),
      ],
      curvedBodyRadius: 25,
      fullyStretchable: false,
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.thumbnail),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
        child: Material(
          color: AppTheme.appThemeColor,
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(AppTheme.primary),
                      overlayColor: MaterialStateProperty.all<Color>(
                          AppTheme.white.withOpacity(0.1)),
                      minimumSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width, 45),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Get Started'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listView() {
    return StreamBuilder<SpecificSubjectModel?>(
      stream: subjectController.specificSubjects(widget.subjectId),
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
                padding: const EdgeInsets.only(top: 0),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data!.subject.chapter.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 2.5),
                  child: MaterialButton(
                    onPressed: () {
                      Get.to(LessonScreen(
                        chapterId: data.subject.chapter[index].id,
                        title: data.subject.chapter[index].name,
                      ));
                    },
                    elevation: 1.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      isThreeLine: true,
                      dense: true,
                      leading: CircleAvatar(
                        backgroundColor: AppTheme.appThemeColor,
                        child: Text("${index + 1}"),
                      ),
                      title:
                          Text(data.subject.chapter[index].name.toUpperCase()),
                      subtitle: Text(data.subject.chapter[index].description),
                      trailing: IconButton(
                        icon: const Icon(Icons.play_arrow_rounded),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
