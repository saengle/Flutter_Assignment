import 'package:flutter/material.dart';

class AddBookScreen extends StatelessWidget {
  AddBookScreen({Key? key}) : super(key: key);
  final _titleTextcontroller = TextEditingController();
  final _authorTextcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Title'),
          ),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Author'),
          ),
          FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.done,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
