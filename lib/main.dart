import 'package:flutter/material.dart';
import 'package:flutter_assignment/json_exam/model/color_schemes.g.dart';
import 'package:flutter_assignment/stream_counter_app/stream_counter_screen.dart';

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
          useMaterial3: true,
          colorScheme: lightColorScheme,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
        ),
        themeMode: ThemeMode.system,
        home: StreamCounterApp() //  연결
        );
  }
}
