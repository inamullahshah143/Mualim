// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/model/quiz_model.dart';
import 'package:mualim/utils/api_utils.dart';

class QuizController extends GetxController {
  Future<QuizModel?> registrationProcess(int chapterId, context) async {
    try {
      final response = await Dio().post(
        '${ApiUtils.baseUrl}/quiz',
        options: Options(
          headers: {"content-Type": "application/json"},
        ),
        data: {'chapter_id': chapterId},
      );
      if (response.statusCode == 200) {
        return quizModelFromJson(jsonEncode(response.data));
      } else {
        return null;
      }
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(jsonDecode(e.response.toString())['error']),
        ),
      );

      return null;
    }
  }
}
