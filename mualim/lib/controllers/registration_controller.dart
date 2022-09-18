import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mualim/model/registration_model.dart';
import 'package:mualim/utils/api_utils.dart';

class RegistrationController extends GetxController {
  Future<RegistrationModel> registrationProcess(RegistrationModel post) async {
    try {
      final response = await Dio().post(
        '${ApiUtils.base_url}/Register',
        options: Options(
          headers: {"content-Type": "application/json"},
        ),
        data: registrationModelToJson(post),
      );
      print(response.data);
      return registrationModelFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) {
        print(e.response!.statusCode);
      } else {
        print(e.message);
      }
      return registrationModelFromJson(e.message);
    }
  }
}
