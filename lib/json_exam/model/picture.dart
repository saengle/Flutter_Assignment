import 'package:flutter/material.dart';
import 'package:flutter_assignment/json_exam/json_exam.dart';
import 'package:flutter_assignment/json_exam/model/image_search_view_model.dart';
import 'package:provider/provider.dart';

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ImageSearchViewModel>();
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
                      viewModel.fetchImages(_controller.text);
                    },
                    child: const Icon(Icons.search),
                  ),
                  hintText: '검색어를 입력하세요',
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _orientation == Orientation.portrait ? 2 : 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              children: viewModel.images
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
            ),
          ),
        ],
      ),
    );
  }
}
