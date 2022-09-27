import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/main.dart';
import 'package:mualim/model/chapter_model.dart';
import 'package:mualim/model/chapter_status_model.dart';
import 'package:mualim/model/specific_subject_model.dart';
import 'package:mualim/model/subject_model.dart';

import '../utils/api_utils.dart';

class SubjectController extends GetxController {
  Stream<SubjectModel?> loadSubjects(context) async* {
    try {
      final response = await Dio().get(
        '${ApiUtils.baseUrl}/all/subjects',
        options: Options(
          headers: {'Authorization': 'Bearer ${prefs!.getString('token')}'},
        ),
      );
      if (response.statusCode == 200) {
        yield subjectModelFromJson(jsonEncode(response.data));
      } else {
        yield null;
      }
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response!.data['errors']),
        ),
      );
      yield null;
    }
  }

  Stream<SpecificSubjectModel?> specificSubjects(
      int subjectId, context) async* {
    try {
      final response = await Dio().post(
        '${ApiUtils.baseUrl}/subjects',
        data: {'subject_id': subjectId},
        options: Options(
          headers: {'Authorization': 'Bearer ${prefs!.getString('token')}'},
        ),
      );
      if (response.statusCode == 200) {
        yield specificSubjectModelFromJson(jsonEncode(response.data));
      } else {
        yield null;
      }
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response!.data['errors']),
        ),
      );
      yield null;
    }
  }

  Future<ChapterModel?> chapterDetails(int chapterId, context) async {
    try {
      final response = await Dio().post(
        '${ApiUtils.baseUrl}/chapter',
        data: {'chapter_id': chapterId},
        options: Options(
          headers: {'Authorization': 'Bearer ${prefs!.getString('token')}'},
        ),
      );
      if (response.statusCode == 200) {
        return chapterModelFromJson(jsonEncode(response.data));
      } else {
        return null;
      }
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response!.data['errors']),
        ),
      );

      return null;
    }
  }

  Future<ChapterStatusModel?> getEnrolledAndUpdate(
      int subjectId, context) async {
    try {
      await Dio()
          .post(
        '${ApiUtils.baseUrl}/status',
        data: {
          'subject_id': subjectId,
        },
        options: Options(
          headers: {'Authorization': 'Bearer ${prefs!.getString('token')}'},
        ),
      )
          .then((value) async {
        final response = await Dio().post(
          '${ApiUtils.baseUrl}/status/store',
          data: {
            'chapter_no': 1,
            'subject_id': subjectId,
          },
          options: Options(
            headers: {'Authorization': 'Bearer ${prefs!.getString('token')}'},
          ),
        );
        if (response.statusCode == 200) {
          return chapterStatusModelFromJson(jsonEncode(response.data));
        } else {
          return null;
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response!.data),
        ),
      );

      return null;
    }
    return null;
  }
}
