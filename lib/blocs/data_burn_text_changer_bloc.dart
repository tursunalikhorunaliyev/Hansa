import 'dart:async';

class DateBornTextBloC{
  final controller = StreamController<String>();
  Stream<String> get stream => controller.stream;
  StreamSink<String> get streamSink => controller.sink;
}