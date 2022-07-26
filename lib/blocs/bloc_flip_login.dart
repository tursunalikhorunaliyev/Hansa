import 'dart:async';

class BlocFlipLogin {
  final controller = StreamController<bool>.broadcast();
  StreamSink<bool> get sink => controller.sink;
  Stream<bool> get stream => controller.stream;
}

class BlocFlipSingin {
  final controller = StreamController<bool>.broadcast();
  StreamSink<bool> get sink => controller.sink;
  Stream<bool> get stream => controller.stream;
}