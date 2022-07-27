import 'dart:async';

import 'package:video_player/video_player.dart';

class VideoControlBloc {
  final controller = StreamController<String>();
  StreamSink<String> get sink => controller.sink;
  Stream<String> get stream => controller.stream;
}
