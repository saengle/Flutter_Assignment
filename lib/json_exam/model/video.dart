import 'package:flutter/material.dart';
import 'package:flutter_assignment/json_exam/json_exam.dart';
import 'package:flutter_assignment/json_exam/model/video_player.dart';
import 'package:flutter_assignment/json_exam/video_api.dart';

class Video {
  final String tags;
  final String pictureID;
  final String url;

  Video({required this.pictureID, required this.tags, required this.url});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      pictureID: json['picture_id'] as String,
      tags: json['tags'] as String,
      url: json['videos']['large']['url'] as String,
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
                child: FutureBuilder<List<Video>>(
                    future: _videoApi.getVideo(_query),
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

                      final List<Video> videos = snapshot.data!;
                      if (videos.isEmpty) {
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
                        children: videos
                            .where((e) => e.tags.contains(_query))
                            .map((Video videos) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoApp(videos.url)),
                              );
                            },
                            child:
                                Stack(alignment: Alignment.center, children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  "https://i.vimeocdn.com/video/${videos.pictureID}_640x640.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ]),
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
