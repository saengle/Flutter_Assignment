import 'package:flutter/material.dart';
import 'package:flutter_assignment/json_exam/model/picture.dart';
import 'package:flutter_assignment/json_exam/model/video.dart';
import 'package:flutter_assignment/json_exam/picture_api.dart';

class ImageSearchApp extends StatefulWidget {
  const ImageSearchApp({Key? key}) : super(key: key);

  @override
  State<ImageSearchApp> createState() => ImageSearching();
}

class ImageSearching extends State<ImageSearchApp> {
  final _controller = TextEditingController();


  int _selectedIndex = 0;

  final screens = [
    const PictureScreen(),
    const VideoScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'Image Searching',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black26,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.image,
              color: Colors.white,), label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_label, color: Colors.white,), label: '',
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
