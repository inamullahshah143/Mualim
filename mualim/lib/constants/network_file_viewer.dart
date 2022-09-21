import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_view/flutter_file_view.dart';
import 'package:get/get.dart';

import 'local_file_viewer.dart';

class NetworkFileViewerPage extends StatefulWidget {
  final String downloadUrl;
  final String downloadPath;

  const NetworkFileViewerPage({
    Key? key,
    required this.downloadUrl,
    required this.downloadPath,
  }) : super(key: key);

  @override
  State<NetworkFileViewerPage> createState() => _NetworkFileViewerPageState();
}

class _NetworkFileViewerPageState extends State<NetworkFileViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: NetworkFileViewer(
        downloadUrl: widget.downloadUrl,
        downloadPath: widget.downloadPath,
        onViewPressed: () {
          Get.off(LocalFileViewerPage(filePath: widget.downloadPath));
        },
      ),
    );
  }
}
