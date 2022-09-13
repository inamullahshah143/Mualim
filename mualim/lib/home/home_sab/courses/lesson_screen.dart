import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

import '../../../constants/app_theme.dart';

class LessonScreen extends StatefulWidget {
  final String title;
  const LessonScreen({Key? key, required this.title}) : super(key: key);

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
        backgroundColor: AppTheme.placeholder,
        appBar: AppBar(
          backgroundColor: AppTheme.placeholder,
          elevation: 0.0,
          title: Text(widget.title),
          foregroundColor: AppTheme.primary,
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
                    betterPlayerDataSourceList: createDataSet(),
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
                  const Center(
                    child: Text('Attachments'),
                  ),
                  messagesList(),
                ],
              ),
            ),
          ],
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
}

List<BetterPlayerDataSource> createDataSet() {
  List<BetterPlayerDataSource> dataSourceList = <BetterPlayerDataSource>[];
  dataSourceList.add(
    BetterPlayerDataSource(BetterPlayerDataSourceType.network,
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"),
  );
  return dataSourceList;
}
