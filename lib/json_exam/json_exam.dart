import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/json_exam/components/data.dart';
import 'package:flutter_assignment/json_exam/model/picture.dart';


class ImageSearching extends StatelessWidget {
  const ImageSearching({Key? key}) : super(key: key);



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
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      suffixIcon: Icon(Icons.search),
                      hintText: '검색어를 입력하세요',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<Picture>>(
                    future: getImages(),
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
                        return Center(
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
                          children: images.where((e) => e.tags.contains('red') ||
                              e.tags.contains('co mputer'))
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

  Future<List<Picture>> getImages() async {
    await Future.delayed(const Duration(seconds: 2));

    String jsonString = jsonData; //jsonData 받아옴 (String타입)
    Map<String, dynamic> json = jsonDecode(jsonString); //String타입 데이터를 Map으로 변환
    List<dynamic> hits = json['hits']; // json(Map)에서 hits로 들어가서 List형식으로 변환.(hits 안의 정보들만)
    return hits.map((e) => Picture.fromJson(e)).toList();
  }
}


