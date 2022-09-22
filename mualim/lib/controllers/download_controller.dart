import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadController extends GetxController {
  Future downloadFile(String url) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      const folderName = 'Mualim';
      final path = Directory('/storage/emulated/0/Download/$folderName');
      if ((await path.exists())) {
      } else {
        path.create();
      }
      await FlutterDownloader.enqueue(
        fileName: url.split('/').last,
        saveInPublicStorage: true,
        url: url,
        savedDir: '/storage/emulated/0/Download',
        showNotification: true,
        openFileFromNotification: true,
      );
    }
  }
}
