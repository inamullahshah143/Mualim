import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

import '../../../constants/app_theme.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({Key? key}) : super(key: key);

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  TabController? tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayerPlaylist(
                betterPlayerConfiguration: const BetterPlayerConfiguration(),
                betterPlayerPlaylistConfiguration:
                    const BetterPlayerPlaylistConfiguration(),
                betterPlayerDataSourceList: createDataSet(),
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
                children: const [
                  Center(
                    child: Text('Attachments'),
                  ),
                  Center(
                    child: Text('Discussion'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<BetterPlayerDataSource> createDataSet() {
  List<BetterPlayerDataSource> dataSourceList = <BetterPlayerDataSource>[];
  dataSourceList.add(
    BetterPlayerDataSource(BetterPlayerDataSourceType.network,
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"),
  );
  return dataSourceList;
}
