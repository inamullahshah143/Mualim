import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/constants/pdf_view.dart';
import 'package:mualim/constants/youtube_video_player.dart';
import 'package:mualim/controllers/download_controller.dart';
import 'package:mualim/controllers/quiz_controller.dart';
import 'package:mualim/controllers/subject_controller.dart';
import 'package:mualim/home/home_sab/courses/quiz_screen.dart';
import 'package:mualim/model/chapter_model.dart';
import 'package:mualim/utils/api_utils.dart';
import '../../../constants/app_theme.dart';

class LessonScreen extends StatefulWidget {
  final int chapterId;

  const LessonScreen({Key? key, required this.chapterId}) : super(key: key);

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  List<String> files = [];
  List sampleData = [];

  String? activeVideo;
  TabController? tabController;
  void handleClick(String value) {
    switch (value) {
      case 'Download':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final subjectController = Get.put(SubjectController());
    final quizController = Get.put(QuizController());
    final downloadController = Get.put(DownloadController());
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
              return Scaffold(
                body: Text('Error: ${snapshot.error}'),
              );
            } else {
              final data = snapshot.data;
              activeVideo =
                  data!.chapter.videos.isEmpty ? '' : data.chapter.videos.first;
              files.clear();
              for (var element in data.chapter.files) {
                files.add(ApiUtils.storageUrl + element);
              }

              return Scaffold(
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
                            onTap: () {
                              processLoading(context);
                              downloadController
                                  .downloadVideo(activeVideo)
                                  .whenComplete(() {
                                Navigator.of(context).pop();
                              });
                            },
                          );
                        }).toList();
                      },
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    data.chapter.videos.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              clipBehavior: Clip.hardEdge,
                              child: YoutubeVideoPlayer(
                                youtubeUrl: activeVideo!,
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 200,
                            child: Center(child: Text('No video found')),
                          ),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          data.chapter.videos.isNotEmpty
                              ? SizedBox(
                                  height: 175,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.chapter.videos.length,
                                    itemBuilder: ((context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5),
                                        child: SizedBox(
                                          width: 175,
                                          child: MaterialButton(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              setState(() {
                                                activeVideo =
                                                    data.chapter.videos[index];
                                              });
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      width: 100,
                                                      height: 100,
                                                      decoration:
                                                          const BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                            'assets/icons/youtube.png',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Lecture Video ${index + 1}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                )
                              : Container(),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.chapter.files.length,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5),
                                child: MaterialButton(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    Get.to(
                                      Reader(
                                        file: ApiUtils.storageUrl +
                                            data.chapter.files[index],
                                        title: data.chapter.files[index]
                                            .split('/')
                                            .last,
                                        isFromPath: false,
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  'assets/icons/pdf_icon.png',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data.chapter.files[index]
                                                      .split('/')
                                                      .last,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Icon(Icons.arrow_forward_ios),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
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
                      backgroundColor:
                          MaterialStateProperty.all<Color>(AppTheme.white),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(AppTheme.primary),
                      overlayColor: MaterialStateProperty.all<Color>(
                          AppTheme.primary.withOpacity(0.1)),
                      minimumSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width, 45),
                      ),
                      elevation: MaterialStateProperty.all(1.0),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(color: AppTheme.primary),
                        ),
                      ),
                    ),
                    onPressed: () {
                      quizController
                          .getQuizzes(widget.chapterId, context)
                          .then((value) {
                        sampleData.clear();
                        for (var element in value!.quiz) {
                          sampleData.add(
                            {
                              "id": element.id,
                              "question": element.question,
                              "options": element.options,
                              "answer_index": element.correctIndex,
                            },
                          );
                        }
                      }).whenComplete(() {
                        Get.to(QuizScreen(sampleData: sampleData));
                      });
                    },
                    child: const Text('Start Quiz'),
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
