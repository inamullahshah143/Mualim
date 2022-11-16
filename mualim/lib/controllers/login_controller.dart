import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/main.dart';
import 'package:mualim/model/login_model.dart';
import 'package:mualim/utils/api_utils.dart';

class LoginController extends GetxController {
  Future<LoginModel?> loginProcess(Map<String, dynamic> data, context) async {
    try {
      final response = await Dio().post(
        '${ApiUtils.baseUrl}/login',
        options: Options(
          headers: {"content-Type": "application/json"},
        ),
        data: data,
      );
      if (response.statusCode == 201) {
        return loginModelFromJson(jsonEncode(response.data));
      } else {
        return null;
      }
    } on DioError catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response!.data['message'].toString()),
        ),
      );

      return null;
    }
  }

  Future<String> logoutProcess(context) async {
    try {
      final response = await Dio().get(
        '${ApiUtils.baseUrl}/logout',
        options: Options(
          headers: {'Authorization': 'Bearer ${prefs!.getString('token')}'},
        ),
      );
      if (response.statusCode == 200) {
        return 'success';
      } else {
        return 'error';
      }
    } on DioError catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response!.data['message'].toString()),
        ),
      );

      return 'error';
    }
  }
}
