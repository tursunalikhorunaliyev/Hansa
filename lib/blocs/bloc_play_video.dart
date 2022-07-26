import 'dart:async';

class BlocPlayVideo {
  final controller = StreamController<bool>.broadcast();
  StreamSink<bool> get sink => controller.sink;
  Stream<bool> get stream => controller.stream;
}