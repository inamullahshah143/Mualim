import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mualim/utils/api_utils.dart';

class UpdatePasswordController {
  Future<String> updatePassword(Map<String, dynamic> data, context) async {
    try {
      final response = await Dio().post(
        '${ApiUtils.baseUrl}/password_update',
        options: Options(
          headers: {"content-Type": "application/json"},
        ),
        data: data,
      );
      if (response.statusCode == 200) {
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
