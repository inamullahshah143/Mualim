import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_youtube_downloader/flutter_youtube_downloader.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
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

  Future<void> downloadVideo(url) async {
  
    final result = await FlutterYoutubeDownloader.downloadVideo(
        url, "Video Title goes Here", 18);
    print(result);
  }
}
