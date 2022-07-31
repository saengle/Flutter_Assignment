import 'package:flutter/material.dart';
import 'package:flutter_assignment/stream_counter_app/stream_counter_api.dart';
import 'package:google_fonts/google_fonts.dart';

class StreamCounterApp extends StatelessWidget {
  StreamCounterApp({Key? key}) : super(key: key);

  final _api = CounterApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카운터 Stream 버전'),
      ),
      body: Center(
        child: StreamBuilder<int>(
            initialData: 0,
            stream: _api.countStream,
            builder: (context, snapshot) {
              return Text('${snapshot.data}',
                  style: GoogleFonts.jua(fontSize: 80));
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _api.increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
