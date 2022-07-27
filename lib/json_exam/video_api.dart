import 'dart:convert';
import 'package:flutter_assignment/json_exam/model/video.dart';
import 'package:http/http.dart' as http;


class VideoApi {

  Future<List<Video>> getVideo(String query) async {
    Uri url = Uri.parse(
        'https://pixabay.com/api/videos/?key=28869366-b0b23ca4e1fa22bc5120beabe&q=$query');

    http.Response response = await http.get(url);
    String jsonString = response.body;
    Map<String, dynamic> json = jsonDecode(jsonString); //String타입 데이터를 Map으로 변환
    List<dynamic> hits =
    json['hits']; // json(Map)에서 hits로 들어가서 List형식으로 변환.(hits 안의 정보들만)
    return hits.map((e) => Video.fromJson(e)).toList();
  }
}