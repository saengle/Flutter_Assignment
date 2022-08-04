import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/book_managing_app/update_book/update_book_view_model.dart';

class UpdateBookScreen extends StatefulWidget {
  final DocumentSnapshot document;

  const UpdateBookScreen(this.document, {Key? key}) : super(key: key);

  @override
  State<UpdateBookScreen> createState() => _UpdateBookScreen();
}

class _UpdateBookScreen extends State<UpdateBookScreen> {
  final _titleTextController = TextEditingController();
  final _authorTextController = TextEditingController();

  final viewModel = UpdateBookViewModel();

  Map<String, dynamic> data = {};

  @override
  void initState() {
    data = widget.document.data()! as Map<String, dynamic>;
    super.initState();
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _authorTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('도서 관리'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _titleTextController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: data['title'],
            ),
          ),
          TextField(
            controller: _authorTextController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: data['author'],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              viewModel.updateBook(
                document: widget.document,
                title: _titleTextController.text,
                author: _authorTextController.text,
              );
              Navigator.pop(context);
            },
            child: const Icon(Icons.save),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
