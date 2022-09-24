import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:get/get.dart';
import 'package:mualim/constants/pdf_view.dart';
import 'package:mualim/controllers/download_controller.dart';
import 'package:mualim/controllers/subject_controller.dart';
import 'package:mualim/model/chapter_model.dart';
import 'package:mualim/utils/api_utils.dart';
import '../../../constants/app_theme.dart';

final subjectController = Get.put(SubjectController());

final downloadController = Get.put(DownloadController());

class LessonScreen extends StatefulWidget {
  final int chapterId;

  const LessonScreen({Key? key, required this.chapterId}) : super(key: key);

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
    return FutureBuilder<ChapterModel?>(
      future: subjectController.chapterDetails(widget.chapterId, context),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final data = snapshot.data;
              files.clear();
              for (var element in data!.chapter.files) {
                files.add(ApiUtils.storageUrl + element);
              }

              return DefaultTabController(
                length: 2,
                child: Scaffold(
                  backgroundColor: AppTheme.placeholder,
                  appBar: AppBar(
                    backgroundColor: AppTheme.placeholder,
                    elevation: 0.0,
                    title: Text(data.chapter.name),
                    foregroundColor: AppTheme.primary,
                    actions: [
                      PopupMenuButton<String>(
                        onSelected: handleClick,
                        itemBuilder: (BuildContext context) {
                          return {'Download'}.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                              onTap: () {},
                            );
                          }).toList();
                        },
                      ),
                    ],
                  ),
                  body: Column(
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
                              betterPlayerDataSourceList:
                                  createDataSet(data.chapter.videos),
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
                            Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: data.chapter.files.length,
                                  itemBuilder: ((context, index) {
                                    return MaterialButton(
                                      onPressed: () {
                                        Get.to(
                                          Reader(
                                            file: ApiUtils.storageUrl +
                                                data.chapter.files[index],
                                            title: data.chapter.files[index]
                                                .split('/')
                                                .last,
                                          ),
                                        );
                                      },
                                      child: const Text('Open File'),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            messagesList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(AppTheme.primary),
                        overlayColor: MaterialStateProperty.all<Color>(
                            AppTheme.primary.withOpacity(0.1)),
                        minimumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width, 45),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
        }
      },
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

  List<BetterPlayerDataSource> createDataSet(List<String> url) {
    List<BetterPlayerDataSource> dataSourceList = <BetterPlayerDataSource>[];
    for (var element in url) {
      dataSourceList.add(
        BetterPlayerDataSource(
            BetterPlayerDataSourceType.network, ApiUtils.storageUrl + element),
      );
    }

    return dataSourceList;
  }
}
