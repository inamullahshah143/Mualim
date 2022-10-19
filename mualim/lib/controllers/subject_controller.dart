import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/helper/genrate_certificate.dart';
import 'package:mualim/main.dart';
import 'package:mualim/model/chapter_model.dart';
import 'package:mualim/model/chapter_status_model.dart';
import 'package:mualim/model/current_status_model.dart';
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

  Future<ChapterStatusModel?> getEnrolledIntoChapter(
      int subjectId, context) async {
    try {
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
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response!.data),
        ),
      );
      return null;
    }
  }

  Future<CurrentStatusModel?> getCurrentChapter(int subjectId, context) async {
    try {
      final response = await Dio().post(
        '${ApiUtils.baseUrl}/status',
        data: {
          'subject_id': subjectId,
        },
        options: Options(
          headers: {'Authorization': 'Bearer ${prefs!.getString('token')}'},
        ),
      );
      if (response.statusCode == 200) {
        return currentStatusModelFromJson(jsonEncode(response.data));
      } else {
        return null;
      }
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response!.data),
        ),
      );

      return null;
    }
  }

  Future<ChapterStatusModel?> updateChapterIndex(
      int subjectId, context, score, total) async {
    int length = 0;
    int chapterId = 0;
    double percantage = (score / total) * 100;

    try {
      await Dio()
          .post(
        '${ApiUtils.baseUrl}/subjects',
        data: {
          'subject_id': subjectId,
        },
        options: Options(
          headers: {'Authorization': 'Bearer ${prefs!.getString('token')}'},
        ),
      )
          .then((value) async {
        length = value.data['subject']['chapter'].length;
      }).whenComplete(() async {
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
          chapterId = value.data['satus']['chapter_id'];
          if (int.parse(value.data['satus']['chapter_no']) < length &&
              percantage >= 50) {
            final response = await Dio().post(
              '${ApiUtils.baseUrl}/status/store',
              data: {
                'chapter_no': int.parse(value.data['satus']['chapter_no']) + 1,
                'subject_id': subjectId,
              },
              options: Options(
                headers: {
                  'Authorization': 'Bearer ${prefs!.getString('token')}'
                },
              ),
            );

            if (response.statusCode == 200) {
              return chapterStatusModelFromJson(jsonEncode(response.data));
            } else {
              return null;
            }
          } else if (int.parse(value.data['satus']['chapter_no']) == length &&
              percantage >= 50) {
            final response = await Dio().post(
              '${ApiUtils.baseUrl}/status/store',
              data: {
                'chapter_no': int.parse(value.data['satus']['chapter_no']) + 1,
                'subject_id': subjectId,
              },
              options: Options(
                headers: {
                  'Authorization': 'Bearer ${prefs!.getString('token')}'
                },
              ),
            );

            if (response.statusCode == 200) {
              CourseCompletionCertificatePdf(context).createPDF();
              return chapterStatusModelFromJson(jsonEncode(response.data));
            } else {
              return null;
            }
          }
        }).whenComplete(() async {
          await Dio().post(
            '${ApiUtils.baseUrl}/score/store',
            data: {
              'subject_id': subjectId,
              'chapter_id': chapterId,
              'score': percantage,
            },
            options: Options(
              headers: {'Authorization': 'Bearer ${prefs!.getString('token')}'},
            ),
          );
        });
      });
    } on DioError catch (e) {
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
