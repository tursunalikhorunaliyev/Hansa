import 'dart:async';

class BlocChangeTitle {
  final controller = StreamController<dynamic>();
  StreamSink<dynamic> get titleSink => controller.sink;
  Stream<dynamic> get titleStream => controller.stream;

  close() {
    controller.close();
  }
}

class BlocChangeTitleIndex {
  final controller = StreamController<int>();
  StreamSink<int> get titleSink => controller.sink;
  Stream<int> get titleStream => controller.stream;

  close() {
    controller.close();
  }
}
