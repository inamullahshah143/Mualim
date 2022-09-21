import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mualim/model/chapter_model.dart';
import 'package:mualim/model/specific_subject_model.dart';
import 'package:mualim/model/subject_model.dart';

import '../utils/api_utils.dart';

class SubjectController extends GetxController {
  Stream<SubjectModel?> loadSubjects() async* {
    try {
      final response = await Dio().get(
        '${ApiUtils.baseUrl}/all/subjects',
        options: Options(
          headers: {
            'Authorization': 'Bearer 9|GSCv5xEga70j4SXZjBKwVrDTE47SgfaNdwThsosZ'
          },
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        yield subjectModelFromJson(jsonEncode(response.data));
      } else {
        yield null;
      }
    } on DioError catch (e) {
      print(e.response);
      yield null;
    }
  }

  Stream<SpecificSubjectModel?> specificSubjects(int subjectId) async* {
    try {
      final response = await Dio().post(
        '${ApiUtils.baseUrl}/subject',
        data: {'subject_id': subjectId},
        options: Options(
          headers: {
            'Authorization': 'Bearer 9|GSCv5xEga70j4SXZjBKwVrDTE47SgfaNdwThsosZ'
          },
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        yield specificSubjectModelFromJson(jsonEncode(response.data));
      } else {
        yield null;
      }
    } on DioError catch (e) {
      print(e.response);
      yield null;
    }
  }

  Future<ChapterModel?> chapterDetails(int subjectId) async {
    try {
      final response = await Dio().post(
        '${ApiUtils.baseUrl}/subject',
        data: {'subject_id': subjectId},
        options: Options(
          headers: {
            'Authorization': 'Bearer 9|GSCv5xEga70j4SXZjBKwVrDTE47SgfaNdwThsosZ'
          },
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        return chapterModelFromJson(jsonEncode(response.data));
      } else {
        return null;
      }
    } on DioError catch (e) {
      print(e.response);

      return null;
    }
  }
}
