import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/model/youtube_video_details_model.dart';

class YoutubeVideoDetailsController extends GetxController {
  Future<YoutubeVideoDetailsModel?> getDetail(url, context) async {
    try {
      final response = await Dio().get(
        'https://www.youtube.com/oembed?url=$url&format=json',
      );
      if (response.statusCode == 200) {
        return youtubeVideoDetailsModelFromJson(jsonEncode(response.data));
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

  Future<List<Map<String, dynamic>>?> videoList(urls, context) async {
    List<Map<String, dynamic>> videoDetail = [];
    try {
      for (var url in urls) {
        await getDetail(url, context).then((value) {
          videoDetail.add({
            'baseUrl': url,
            'title': value!.title,
            'thumbnail': value.thumbnailUrl
          });
        });
      }
      return videoDetail;
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
