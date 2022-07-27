import 'package:flutter/material.dart';
import 'package:flutter_assignment/json_exam/json_exam.dart';
import 'package:flutter_assignment/json_exam/video_api.dart';

class Video {
  final String tags;
  final String previewURL;

  Video({
    required this.previewURL,
    required this.tags
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      previewURL: json['previewURL'] as String,
      tags: json['tags'] as String,
    );
  }
}
class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final _controller = TextEditingController();
  String _query = '';
  final _videoApi = VideoApi();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                child: FutureBuilder<List<Video>>(
                    future: _videoApi.getVideo(_query),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('에러가 발생했습니다'),
                        );
                      }

                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData) {
                        return const Center(
                          child: Text('데이터가 없습니다'),
                        );
                      }

                      final List<Video> images = snapshot.data!;
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
                        children: images
                            .where((e) => e.tags.contains(_query))
                            .map((Video image) {
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


