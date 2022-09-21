import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home_sab/courses/details_courses.dart';

class CustomCoursesCards extends StatelessWidget {
  final int subjectId;
  final String title;
  final String subtitle;
  final int lessons;
  final String thumbnail;
  const CustomCoursesCards({
    Key? key,
    required this.subjectId,
    required this.title,
    required this.lessons,
    required this.thumbnail,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: MaterialButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.zero,
        onPressed: () {
          Get.to(
            () => DetailedCourse(
              subjectId: subjectId,
              lessons: lessons,
              title: title,
              subtitle: subtitle,
              thumbnail: thumbnail,
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(thumbnail),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        subtitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.25,
                        ),
                      ),
                      Text(
                        '$lessons Lessons',
                        style: const TextStyle(
                          fontSize: 10,
                          height: 1.5,
                          fontWeight: FontWeight.w200,
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
  }
}
