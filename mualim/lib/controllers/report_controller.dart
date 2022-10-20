import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mualim/main.dart';
import 'package:mualim/model/report_model.dart';
import 'package:mualim/utils/api_utils.dart';

class ReportController {
  Stream<ReportModel?> getReports(context) async* {
    try {
      final response = await Dio().get(
        '${ApiUtils.baseUrl}/report',
        options: Options(
          headers: {'Authorization': 'Bearer ${prefs!.getString('token')}'},
        ),
      );
      if (response.statusCode == 201) {
        yield reportModelFromJson(jsonEncode(response.data));
      } else {
        yield null;
      }
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response!.data),
        ),
      );
      yield null;
    }
  }
}
