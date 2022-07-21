import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/json_exam/components/data.dart';
import 'package:flutter_assignment/json_exam/model/picture.dart';


class ImageSearching extends StatefulWidget {
  const ImageSearching({Key? key}) : super(key: key);

  @override
  State<ImageSearching> createState() => ImageSearchingMain();
}

class ImageSearchingMain extends State<ImageSearching> {
  List<Picture> data = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future initData() async {
    data = await getImages();
    setState(() {});
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
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
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
              mySizeBox(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: data.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : GridView.builder(
                    itemCount: data.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      Picture image = data[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          image.previewURL,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
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
    Map<String, dynamic> json = jsonDecode(jsonString);
    Iterable hits = json['hits'];
    return hits.map((e) => Picture.fromJson(e)).toList();
  }
}
