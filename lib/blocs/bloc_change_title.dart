import 'dart:async';

class BlocChangeTitle {
  final controller = StreamController<dynamic>();
  StreamSink<dynamic> get titleSink => controller.sink;
  Stream<dynamic> get titleStream => controller.stream;

  close(){
    controller.close();
  }
}