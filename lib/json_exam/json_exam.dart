import 'package:flutter/material.dart';
import 'package:flutter_assignment/json_exam/model/picture.dart';
import 'package:flutter_assignment/json_exam/model/video.dart';
import 'package:google_fonts/google_fonts.dart';

// Search App 만들기 .
class ImageSearchApp extends StatefulWidget {
  const ImageSearchApp({Key? key}) : super(key: key);

  @override
  State<ImageSearchApp> createState() => ImageSearching();
}

class ImageSearching extends State<ImageSearchApp> {
  int _selectedIndex = 0;

  final screenBodies = const [
    PictureScreen(),
    VideoScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Search',
            style: GoogleFonts.jua(
              textStyle: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ),
      ),
      body: screenBodies[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.image,
              color: Colors.white,
            ),
            label: 'Image',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.video_label,
              color: Colors.white,
            ),
            label: 'Video',
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
