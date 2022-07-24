import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/json_exam/components/data.dart';
import 'package:flutter_assignment/json_exam/model/picture.dart';
import 'package:http/http.dart' as http;

class ImageSearchApp extends StatefulWidget {
  const ImageSearchApp({Key? key}) : super(key: key);

  @override
  State<ImageSearchApp> createState() => ImageSearching();
}


class ImageSearching extends State<ImageSearchApp> {

  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              'Image Searching App',
              style: TextStyle(fontSize: 20,
              color: Colors.black),
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              mySizeBox(),
               Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _query = _controller.text;
                          });
                        },
                        child: const Icon(Icons.search),
                      ),
                      hintText: '검색어를 입력하세요',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<Picture>>(
                    future: getImages(_query),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('에러가 발생했습니다'),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData) {
                        return const Center(
                          child: Text('데이터가 없습니다'),
                        );
                      }

                      final List<Picture> images = snapshot.data!;
                      if (images.isEmpty) {
                        return const Center(
                          child: Text('데이터가 0개입니다.'),
                        );
                      }

                      return GridView(
                        gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                          children: images.where((e) => e.tags.contains(_query))
                          .map((Picture image) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                image.previewURL,
                                fit: BoxFit.cover,
                              ),
                            );
                          }).toList(),
                      );
                    }
                  )

                ),
              ),
            ],
          ),
        ),
      );
  }

  Widget mySizeBox() {
    return const SizedBox(
      height: 10,
    );
  }

  Future<List<Picture>> getImages(String query) async {
   Uri url = Uri.parse('https://pixabay.com/api/?key=10711147-dc41758b93b263957026bdadb&q=$query&image_type=photo');
   http.Response response = await http.get(url);
   print('Response status: ${response.statusCode}');


    String jsonString = response.body;
    Map<String, dynamic> json = jsonDecode(jsonString); //String타입 데이터를 Map으로 변환
    List<dynamic> hits = json['hits']; // json(Map)에서 hits로 들어가서 List형식으로 변환.(hits 안의 정보들만)
    return hits.map((e) => Picture.fromJson(e)).toList();
  }
}


