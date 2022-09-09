import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';

class DetailedCourse extends StatelessWidget {
  final String title;
  final int lessons;
  final String thumbnail;
  const DetailedCourse(
      {Key? key,
      required this.title,
      required this.lessons,
      required this.thumbnail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      title: Text(title),
      headerWidget: headerWidget(context),
      headerBottomBar: Text(title),
      body: [
        listView(),
      ],
      fullyStretchable: true,
      backgroundColor: Colors.white,
    );
  }

  Row headerBottomBarWidget() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(
          Icons.settings,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(thumbnail),
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
            child: Text("$index"),
          ),
          title: const Text("Title"),
          subtitle: const Text("Subtitile"),
        ),
      ),
    );
  }
}
