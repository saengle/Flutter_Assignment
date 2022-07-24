import 'package:flutter/material.dart';
import 'package:flutter_assignment/futurebuilder_assignment/futurebuilder_assignment.dart';
import 'package:flutter_assignment/json_exam/json_exam.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ImageSearchApp()     //  연결 필요
    );
  }
}
