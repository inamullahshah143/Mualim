import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mualim/model/login_model.dart';
import 'package:mualim/utils/api_utils.dart';

class LoginController extends GetxController {
  Future<LoginModel?> loginProcess(
      Map<String, dynamic> data) async {
    print(data);
    try {
      final response = await Dio().post(
        '${ApiUtils.baseUrl}/login',
        options: Options(
          headers: {"content-Type": "application/json"},
        ),
        data: data,
      );
      if (response.statusCode == 201) {
        print(response.data);
        return loginModelFromJson(jsonEncode(response.data));
      } else {
        return null;
      }
    } on DioError catch (e) {
      print(e.response);

      return null;
    }
  }
}