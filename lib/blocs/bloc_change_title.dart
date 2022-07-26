import 'dart:async';

class BlocChangeTitle {
  final controller = StreamController<String>.broadcast();
  StreamSink<String> get titleSink => controller.sink;
  Stream<String> get titleStream => controller.stream;
}