import 'package:cloud_firestore/cloud_firestore.dart';

class AddBookViewModel {
  final _db = FirebaseFirestore.instance;

  Future addBook(String title, String author) async {
    _db.collection('books').add({
      "title": title,
      "author": author,
    });
    print(reference.id);
  }
}
