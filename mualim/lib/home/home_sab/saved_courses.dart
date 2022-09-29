import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/constants/pdf_view.dart';

import '../../controllers/subject_controller.dart';

final subjectController = Get.put(SubjectController());

class SavedCourses extends StatefulWidget {
  const SavedCourses({Key? key}) : super(key: key);

  @override
  State<SavedCourses> createState() => _SavedCoursesState();
}

class _SavedCoursesState extends State<SavedCourses> {
  var dir = Directory('/storage/emulated/0/Download/Mualim');
  List? contents;
  List filePath = [];
  @override
  void initState() {
    contents = dir.listSync();
    for (var fileOrDir in contents!) {
      if (fileOrDir is File) {
        filePath.add(fileOrDir.path);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: filePath.length,
      itemBuilder: ((context, index) {
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
                Reader(
                  file: filePath[index],
                  title: filePath[index].split('/').last,
                  isFromPath: true,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            filePath[index].split('/').last,
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
    );
  }
}
