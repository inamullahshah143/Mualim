import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/main.dart';
import 'package:mualim/model/search_model.dart';
import 'package:mualim/utils/api_utils.dart';

class SearchController extends GetxController {
  Future<SearchModel?> searchChapters(String searchKey, context) async {
    try {
      final response = await Dio().post(
        '${ApiUtils.baseUrl}/search',
        options: Options(
          headers: {'Authorization': 'Bearer ${prefs!.getString('token')}'},
        ),
        data: {
          'name': searchKey,
        },
      );
      if (response.statusCode == 200) {
        return searchModelFromJson(jsonEncode(response.data));
      } else {
        return null;
      }
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response!.data.toString()),
        ),
      );
      return null;
    }
  }
}
