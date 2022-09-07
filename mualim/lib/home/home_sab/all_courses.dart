import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/lesson.dart';

class AllCourses extends StatefulWidget {
  const AllCourses({Key? key}) : super(key: key);

  @override
  State<AllCourses> createState() => _AllCoursesState();
}

class _AllCoursesState extends State<AllCourses> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        makeLessonListTile(Lesson('title', 10, 'level')),
        ElevatedButton(
          onPressed: () async {
            final status = await Permission.storage.request();

            if (status.isGranted) {
              final externalDir = await getExternalStorageDirectory();
              await FlutterDownloader.enqueue(
                url:
                    "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
                savedDir: externalDir!.path,
                showNotification: true,
                openFileFromNotification: true,
                saveInPublicStorage: true,
              ).whenComplete(() {});
            } else {}
          },
          child: const Text('Download'),
        ),
      ],
    );
  }

  ListTile makeLessonListTile(Lesson lesson) => ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.white24))),
          child: IconButton(
            icon: const Icon(Icons.close,
                color: Colors.white), // Hardcoded to be 'x'
            onPressed: () {},
          ),
        ),
        title: Text(
          lesson.title!,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: LinearProgressIndicator(
                backgroundColor: const Color.fromRGBO(209, 224, 224, 0.2),
                value: lesson.indicatorValue,
                valueColor: const AlwaysStoppedAnimation(Colors.green),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  lesson.level!,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
        trailing: const Icon(Icons.keyboard_arrow_right,
            color: Colors.white, size: 30.0),
        onTap: () {},
      );
}
