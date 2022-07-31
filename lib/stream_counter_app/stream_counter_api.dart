import 'dart:async';

class CounterApi {
  int _count = 0;
  final _counterStreamController = StreamController<int>();

  Stream<int> get countStream => _counterStreamController.stream;

  void increment() {
    _count++;
    _counterStreamController.add(_count);
  }
}