import 'package:flutter/material.dart';
import 'package:flutter_file_view/flutter_file_view.dart';

class LocalFileViewerPage extends StatefulWidget {
  final String filePath;

  const LocalFileViewerPage({
    Key? key,
    required this.filePath,
  }) : super(key: key);
  @override
  State<LocalFileViewerPage> createState() => _LocalFileViewerPageState();
}

class _LocalFileViewerPageState extends State<LocalFileViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("文档")),
      body: LocalFileViewer(filePath: widget.filePath),
    );
  }
}
