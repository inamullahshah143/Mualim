import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:mualim/constants/app_theme.dart';

class DetailedCourse extends StatefulWidget {
  final String title;
  final String subtitle;
  final int lessons;
  final String thumbnail;
  const DetailedCourse(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.lessons,
      required this.thumbnail})
      : super(key: key);

  @override
  State<DetailedCourse> createState() => _DetailedCourseState();
}

class _DetailedCourseState extends State<DetailedCourse> {
  TabController? tabController;
  int selectedTabbar = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: DraggableHome(
        appBarColor: AppTheme.appThemeColor,
        title: Text(widget.title),
        headerWidget: headerWidget(context),
        body: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              color: AppTheme.appThemeColor,
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.subtitle,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TabBar(
              controller: tabController,
              labelColor: AppTheme.white,
              unselectedLabelColor: AppTheme.fonts,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppTheme.appThemeColor,
              ),
              onTap: (index) {
                setState(() {
                  selectedTabbar = index;
                });
              },
              tabs: const [
                Tab(text: 'Lessons'),
                Tab(text: 'Discussions'),
              ],
            ),
          ),
          IntrinsicHeight(
            child: Column(
              children: [
                selectedTabbar == 0 ? listView() : messagesList(),
              ],
            ),
          ),
        ],
        fullyStretchable: false,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.thumbnail),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  ListView listView() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 20,
      shrinkWrap: true,
      itemBuilder: (context, index) => Card(
        color: Colors.white70,
        child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppTheme.appThemeColor,
              child: Text("${index + 1}"),
            ),
            title: const Text("Lesson Title"),
            subtitle: const Text("Details"),
            trailing: IconButton(
              icon: const Icon(Icons.play_arrow_rounded),
              onPressed: () {},
            )),
      ),
    );
  }

  ListView messagesList() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      shrinkWrap: true,
      itemBuilder: (context, index) => Card(
        color: Colors.white70,
        child: ListTile(
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
                  fontSize: 8,
                ),
              ),
              onPressed: () {},
            )),
      ),
    );
  }
}
