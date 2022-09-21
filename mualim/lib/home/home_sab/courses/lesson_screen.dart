import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mualim/constants/local_file_viewer.dart';
import 'package:mualim/constants/network_file_viewer.dart';
import 'package:mualim/controllers/subject_controller.dart';
import 'package:mualim/model/chapter_model.dart';
import 'package:mualim/utils/api_utils.dart';
import 'package:path_provider/path_provider.dart';

import '../../../constants/app_theme.dart';

final subjectController = Get.put(SubjectController());

class LessonScreen extends StatefulWidget {
  final int chapterId;
  final String title;

  const LessonScreen({Key? key, required this.title, required this.chapterId})
      : super(key: key);

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  List<String> files = [];
  TabController? tabController;
  void handleClick(String value) {
    switch (value) {
      case 'Download':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.placeholder,
        appBar: AppBar(
          backgroundColor: AppTheme.placeholder,
          elevation: 0.0,
          title: Text(widget.title),
          foregroundColor: AppTheme.primary,
          actions: [
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Download'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: FutureBuilder<ChapterModel?>(
          future: subjectController.chapterDetails(widget.chapterId,context),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Text('Loading....');
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final data = snapshot.data;

                  files.add(
                      ApiUtils.storageUrl + data!.chapter.content.first.file);

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: BetterPlayerPlaylist(
                              betterPlayerConfiguration:
                                  const BetterPlayerConfiguration(),
                              betterPlayerPlaylistConfiguration:
                                  const BetterPlayerPlaylistConfiguration(),
                              betterPlayerDataSourceList: createDataSet(
                                  data.chapter.content.first.video),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: TabBar(
                          controller: tabController,
                          labelColor: AppTheme.white,
                          unselectedLabelColor: AppTheme.fonts,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppTheme.appThemeColor,
                          ),
                          tabs: const [
                            Tab(text: 'Attachments'),
                            Tab(text: 'Discussion'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: files.length,
                                    itemBuilder: (context, index) {
                                      String filePath = files[index];
                                      String fileShowText = '';

                                      int i = filePath.lastIndexOf('/');
                                      if (i <= -1) {
                                        fileShowText = filePath;
                                      } else {
                                        fileShowText =
                                            filePath.substring(i + 1);
                                      }

                                      int j = fileShowText.lastIndexOf('.');

                                      String title = '';
                                      String type = '';

                                      if (j > -1) {
                                        title = fileShowText.substring(0, j);
                                        type = fileShowText
                                            .substring(j + 1)
                                            .toLowerCase();
                                      }

                                      final child = ElevatedButton(
                                        onPressed: () {
                                          if (filePath.contains('http://') ||
                                              filePath.contains('https://')) {
                                            onNetworkTap(title, type, filePath);
                                          } else {
                                            onLocalTap(
                                                type, 'assets/files/$filePath');
                                          }
                                        },
                                        child: Text(fileShowText),
                                      );

                                      return Container(
                                        margin:
                                            const EdgeInsets.only(top: 10.0),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: child,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            messagesList(),
                          ],
                        ),
                      ),
                    ],
                  );
                }
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              foregroundColor:
                  MaterialStateProperty.all<Color>(AppTheme.primary),
              overlayColor: MaterialStateProperty.all<Color>(
                  AppTheme.primary.withOpacity(0.1)),
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width, 45),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: AppTheme.primary),
                ),
              ),
            ),
            onPressed: () {},
            child: const Text('Start Quiz'),
          ),
        ),
      ),
    );
  }

  ListView messagesList() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      shrinkWrap: true,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.5),
        child: MaterialButton(
          onPressed: () {},
          elevation: 0.0,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: const CircleAvatar(
              backgroundColor: AppTheme.appThemeColor,
              child: Icon(Icons.person_outline),
            ),
            title: const Text("Username"),
            subtitle: const Text("Message...."),
            trailing: IconButton(
              icon: const Text(
                '01:00 PM',
                style: TextStyle(
                  fontSize: 7,
                ),
              ),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }

  Future onLocalTap(String type, String assetPath) async {
    String filePath = await setFilePath(type, assetPath);
    if (!await asset2Local(type, assetPath)) {
      return;
    }
    Get.to(LocalFileViewerPage(filePath: filePath));
  }

  Future onNetworkTap(String title, String type, String downloadUrl) async {
    String filePath = await setFilePath(type, title);

    if (fileExists(filePath)) {
      Get.to(LocalFileViewerPage(filePath: filePath));
    } else {
      Get.to(NetworkFileViewerPage(
        downloadUrl: downloadUrl,
        downloadPath: filePath,
      ));
    }
  }

  Future asset2Local(String type, String assetPath) async {
    String filePath = await setFilePath(type, assetPath);

    File file = File(filePath);
    if (fileExists(filePath)) {
      await file.delete();
    }

    await file.create(recursive: true);
    ByteData bd = await rootBundle.load(assetPath);
    await file.writeAsBytes(bd.buffer.asUint8List(), flush: true);
    return true;
  }

  Future setFilePath(String type, String assetPath) async {
    final directory = await getTemporaryDirectory();
    return "${directory.path}/fileview/${base64.encode(utf8.encode(assetPath))}.$type";
  }

  bool fileExists(String filePath) => File(filePath).existsSync();
}

List<BetterPlayerDataSource> createDataSet(String url) {
  List<BetterPlayerDataSource> dataSourceList = <BetterPlayerDataSource>[];
  dataSourceList.add(
    BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, ApiUtils.storageUrl + url),
  );
  return dataSourceList;
}
