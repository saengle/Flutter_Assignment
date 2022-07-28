import 'package:flutter/material.dart';
import 'package:flutter_assignment/json_exam/json_exam.dart';
import 'package:flutter_assignment/json_exam/picture_api.dart';

class Picture {
  final String tags;
  final String previewURL;

  Picture({required this.previewURL, required this.tags});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      previewURL: json['previewURL'] as String,
      tags: json['tags'] as String,
    );
  }
}

class PictureScreen extends StatefulWidget {
  const PictureScreen({Key? key}) : super(key: key);

  @override
  State<PictureScreen> createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  final _controller = TextEditingController();
  String _query = '';
  final _pictureApi = PictureApi();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _orientation = MediaQuery.of(context).orientation;
    return Center(
      child: Column(
        children: [
          const MySizedBox(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 2),
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
                    future: _pictureApi.getImages(_query),
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              _orientation == Orientation.portrait ? 2 : 4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        children: images
                            .where((e) => e.tags.contains(_query))
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
                    })),
          ),
        ],
      ),
    );
  }
}
