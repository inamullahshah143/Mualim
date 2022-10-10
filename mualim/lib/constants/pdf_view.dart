import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:mualim/controllers/download_controller.dart';

final downloadController = Get.put(DownloadController());

class Reader extends StatefulWidget {
  final String title;
  final String file;
  final bool isFromPath;

  const Reader(
      {Key? key,
      required this.title,
      required this.file,
      required this.isFromPath})
      : super(key: key);

  @override
  State<Reader> createState() => _ReaderState();
}

class _ReaderState extends State<Reader> {
  final ReceivePort _port = ReceivePort();
  String? id;
  DownloadTaskStatus? status;
  int? progress;
  String? dStatus;
  @override
  void initState() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      setState(() {
        id = data[0];
        status = data[1];
        progress = data[2];
      });

      if (status == DownloadTaskStatus.complete) {
        setState(() {
          dStatus = 'Complete';
        });
      }
      if (status == DownloadTaskStatus.failed) {
        setState(() {
          dStatus = 'Failed';
        });
      }
      if (status == DownloadTaskStatus.running) {
        setState(() {
          dStatus = 'Running';
        });
      }
      if (status == DownloadTaskStatus.canceled) {
        setState(() {
          dStatus = 'Canceled';
        });
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
    createFolder();
    super.initState();
  }

  createFolder() async {
    const folderName = 'Muallim';
    final path = Directory('/storage/emulated/0/Download/$folderName');
    if ((await path.exists())) {
    } else {
      path.create();
    }
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leadingWidth: 30,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          actions: [
            !widget.isFromPath
                ? IconButton(
                    color: Colors.black,
                    onPressed: dStatus == 'Complete'
                        ? null
                        : dStatus == 'Running'
                            ? null
                            : dStatus == 'Canceled'
                                ? () {
                                    downloadController
                                        .downloadFile(widget.file);
                                  }
                                : () {
                                    downloadController
                                        .downloadFile(widget.file);
                                  },
                    icon: dStatus == 'Complete'
                        ? const Icon(
                            Icons.download_done_rounded,
                            color: Colors.green,
                          )
                        : dStatus == 'Failed'
                            ? const Icon(
                                Icons.warning_rounded,
                                color: Colors.yellow,
                              )
                            : dStatus == 'Canceled'
                                ? const Icon(
                                    Icons.download_rounded,
                                    color: Colors.black,
                                  )
                                : dStatus == 'Running'
                                    ? Text(
                                        "$progress%",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : const Icon(Icons.download_rounded),
                  )
                : Container(),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          ),
        ),
        body: Center(
            child: widget.isFromPath
                ? const PDF(enableSwipe: true).fromPath(
                    widget.file,
                  )
                : const PDF(enableSwipe: true).fromUrl(
                    widget.file,
                    placeholder: (progress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorWidget: (error) => Center(
                      child: Text(
                        error.toString(),
                      ),
                    ),
                  )),
      ),
    );
  }
}
