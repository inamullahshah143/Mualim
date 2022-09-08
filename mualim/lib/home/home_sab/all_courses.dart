import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
              ).whenComplete(() {
              });
            } else {
            }
          },
          child: const Text('Download'),
        ),
      ],
    );
  }
}
