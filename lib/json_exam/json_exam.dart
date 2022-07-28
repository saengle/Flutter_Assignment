import 'package:flutter/material.dart';
import 'package:flutter_assignment/json_exam/model/picture.dart';
import 'package:flutter_assignment/json_exam/model/video.dart';


class ImageSearchApp extends StatefulWidget {
  const ImageSearchApp({Key? key}) : super(key: key);

  @override
  State<ImageSearchApp> createState() => ImageSearching();
}

class ImageSearching extends State<ImageSearchApp> {

  int _selectedIndex = 0;

  final screenBody = [
    const PictureScreen(),
    const VideoScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'Search App',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
      body: screenBody[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black26,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.image,
              color: Colors.white,), label: 'Image',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_label, color: Colors.white,), label: 'Video',
          ),
        ],
      ),
    );
  }
}

class MySizedBox extends StatelessWidget {
  const MySizedBox({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10,
    );
  }
}
