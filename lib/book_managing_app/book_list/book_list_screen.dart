import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/book_managing_app/add_book/add_book_screen.dart';
import 'package:flutter_assignment/book_managing_app/book_list/book_list_view_model.dart';
import 'package:flutter_assignment/book_managing_app/update_book/update_book_screen.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class BookListScreen extends StatelessWidget {
  BookListScreen({Key? key}) : super(key: key);

  final viewModel = BookListViewModel();
  final ImagePicker _picker = ImagePicker();

  // byte array
  Uint8List? _bytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('도서 관리 앱'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: viewModel.booksStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['title']),
                  subtitle: Text(data['author']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateBookScreen(document)),
                    );
                  },
                  leading: Image.network(
                    data['imageUrl'],
                    width: 100,
                    height: 100,
                  ),
                );
              }).toList(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBookScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
