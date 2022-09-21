import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/model/registration_model.dart';
import 'package:mualim/utils/api_utils.dart';

class RegistrationController extends GetxController {
  Future<RegistrationModel?> registrationProcess(
      Map<String, dynamic> data, context) async {
    try {
      final response = await Dio().post(
        '${ApiUtils.baseUrl}/Register',
        options: Options(
          headers: {"content-Type": "application/json"},
        ),
        data: data,
      );
      if (response.statusCode == 201) {
        return registrationModelFromJson(jsonEncode(response.data));
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
