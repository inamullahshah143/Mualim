import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/main.dart';
import 'package:mualim/utils/api_utils.dart';

class UserProfileController extends GetxController {
  Future<String> updateProfile(context, Map<String, dynamic> data) async {
    try {
      final response = await Dio().post(
        '${ApiUtils.baseUrl}/profile',
        data: data,
        options: Options(
          headers: {'Authorization': 'Bearer ${prefs!.getString('token')}'},
        ),
      );
      if (response.statusCode == 201) {
        prefs!.setString('username', response.data['data']['name']);
        prefs!.setString('email', response.data['data']['email']);
        prefs!.setString('phone', response.data['data']['phone']);
        return 'success';
      } else {
        return 'error';
      }
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response!.data.toString()),
        ),
      );
      return 'error';
    }
  }
}
