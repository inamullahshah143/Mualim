import 'package:flutter/material.dart';
import 'package:mualim/constants/custom_courses_cards.dart';

class AllCourses extends StatefulWidget {
  const AllCourses({Key? key}) : super(key: key);

  @override
  State<AllCourses> createState() => _AllCoursesState();
}

class _AllCoursesState extends State<AllCourses> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         CustomCoursesCards(lessons: 20, onPressed: (){}, thumbnail: 'https://miro.medium.com/max/1400/1*L76A5gL6176UbMgn7q4Ybg.jpeg', title: 'Mathematics is an area of knowledge that includes such topics as numbers (arithmetic and number theory), formulas and related structures (algebra),',),
         CustomCoursesCards(lessons: 101, onPressed: (){}, thumbnail: 'https://i0.wp.com/academiamag.com/wp-content/uploads/2022/07/Physics_0.jpg', title: 'Physics is the branch of science that deals with the structure of matter and how the fundamental constituents of the universe interact.',),
        ],
    );
  }
}
