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
  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      appBarColor: AppTheme.appThemeColor,
      title: Text(widget.title),
      headerWidget: headerWidget(context),
      body: [
        listView(),
        //  messagesList(),
      ],
      fullyStretchable: false,
      backgroundColor: Colors.white,
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.thumbnail),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
        child: Material(
          color: AppTheme.appThemeColor,
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView listView() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.lessons,
      shrinkWrap: true,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.5),
        child: MaterialButton(
          onPressed: () {},
          elevation: 1.0,
          color: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
              enabled: false,
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
