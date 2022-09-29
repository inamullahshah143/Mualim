import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_youtube_downloader/flutter_youtube_downloader.dart';
import 'package:get/get.dart';
import 'package:mualim/controllers/youtube_video_controller.dart';
// import 'package:permission_handler/permission_handler.dart';

class DownloadController extends GetxController {
  Future downloadFile(String url) async {
    const folderName = 'Mualim';
    final path = Directory('/storage/emulated/0/Download/$folderName');
    if ((await path.exists())) {
    } else {
      path.create();
    }
    await FlutterDownloader.enqueue(
      fileName: url.split('/').last,
      saveInPublicStorage: false,
      url: url,
      savedDir: '/storage/emulated/0/Download/$folderName',
      showNotification: true,
      openFileFromNotification: true,
    );
  }

  Future<void> downloadVideo(url, context) async {
    final youtubeVideoDetailsController =
        Get.put(YoutubeVideoDetailsController());
    await youtubeVideoDetailsController
        .getDetail(url, context)
        .then((value) async {
      await FlutterYoutubeDownloader.downloadVideo(url, value!.title, 18);
    });
  }
}
