import 'package:flutter_assignment/json_exam/model/picture.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PictureApi {

  Future<List<Picture>> getImages(String query) async {
    Uri url = Uri.parse(
        'https://pixabay.com/api/?key=10711147-dc41758b93b263957026bdadb&q=$query&image_type=photo');
    http.Response response = await http.get(url);
    String jsonString = response.body;
    Map<String, dynamic> json = jsonDecode(jsonString); //String타입 데이터를 Map으로 변환
    List<dynamic> hits =
    json['hits']; // json(Map)에서 hits로 들어가서 List형식으로 변환.(hits 안의 정보들만)
    return hits.map((e) => Picture.fromJson(e)).toList();
  }

}