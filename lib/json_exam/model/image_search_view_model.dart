import 'package:flutter/material.dart';
import 'package:flutter_assignment/json_exam/model/picture.dart';
import 'package:flutter_assignment/json_exam/picture_api.dart';

class ImageSearchViewModel extends ChangeNotifier {
  final pictureApi = PictureApi();

  List<Picture> images = [];

  void fetchImages(String query) async {
    images = await pictureApi.getImages(query);
    notifyListeners();
  }
}
