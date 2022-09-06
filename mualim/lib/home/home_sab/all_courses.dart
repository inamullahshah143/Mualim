import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:isolate';
import 'dart:ui';

class AllCourses extends StatefulWidget {
  const AllCourses({Key? key}) : super(key: key);

  @override
  State<AllCourses> createState() => _AllCoursesState();
}

class _AllCoursesState extends State<AllCourses> {
  int progress = 0;
  final ReceivePort _port = ReceivePort();
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    //Callback for the Flutter_Downloader
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  void initState() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');

    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      setState(() {
        progress = data[2];
        print(data[1]);
      });
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$progress",
          style: const TextStyle(fontSize: 40),
        ),
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
                  saveInPublicStorage: true);
            } else {
              print("Permission deined");
            }
          },
          child: const Text('Download'),
        ),
      ],
    );
  }
}
