import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/constants/custom_courses_cards.dart';

import 'courses/details_courses.dart';

class AllCourses extends StatefulWidget {
  const AllCourses({Key? key}) : super(key: key);

  @override
  State<AllCourses> createState() => _AllCoursesState();
}

class _AllCoursesState extends State<AllCourses> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CustomCoursesCards(
          lessons: 20,
          thumbnail:
              'https://miro.medium.com/max/1400/1*L76A5gL6176UbMgn7q4Ybg.jpeg',
          title:
              'Mathematics is an area of knowledge that includes such topics as numbers (arithmetic and number theory), formulas and related structures (algebra),',
        ),
        CustomCoursesCards(
          lessons: 101,
          thumbnail:
              'https://i0.wp.com/academiamag.com/wp-content/uploads/2022/07/Physics_0.jpg',
          title:
              'Physics is the branch of science that deals with the structure of matter and how the fundamental constituents of the universe interact.',
        ),
      ],
    );
  }
}
