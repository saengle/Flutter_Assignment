import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/material.dart';
import 'package:flutter_assignment/json_exam/components/data.dart';

// class 명을 main.dart 연결 필요 부분에 대입해서 확인.
class FutureAssignment1 extends StatelessWidget {
  const FutureAssignment1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'Future Builder 과제 1',
            style: TextStyle(
              fontSize: 20, color: Colors.black,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FutureBuilder(
            future: getjsonData1(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('에러가 발생했습니다.'),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(),);
              }
              if (!snapshot.hasData) {
                return const Center(child: Text('데이터가 없습니다.'),);
              }
              final data = snapshot.data!;

              return Text("""
              $data.userID \n
              $data.id \n
              $data.title \n
              $data.body \n
              """);
            },
          )

        ),
      ),
    );
  }
  Future getjsonData1() async {
  await Future.delayed(const Duration(seconds: 3));

  String _jsonString = jsonDatas; //jsonData 받아옴 (String타입)
 final _json = jsonDecode(_jsonString);
  JsonData jsonData = JsonData.fromJson(_json);
  print(jsonData.id);
}
}

class JsonData {
  final String userId;
  final String id;
  final String title;
  final String body;

  JsonData({
    required this.userId,
    required this.id,
    required this.title,
    required this.body
  });

  factory JsonData.fromJson(Map<String, dynamic> parsedJson) {
    return JsonData(
      userId: parsedJson['userId'] ,
      id: parsedJson['id'] ,
      title: parsedJson['title'] ,
      body: parsedJson['body']
    );
  }
}

String jsonDatas = """{
  "userId": 1,
  "id": 1,
  "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
  "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
}
""";

