import 'dart:async';
import 'dart:convert';

import 'package:hansa_app/video/model_video.dart';
import 'package:http/http.dart';

enum ActionVideo {
  View,
}

class BlocVideoApi {
  final dataController = StreamController<VideoMainOne>.broadcast();
  StreamSink<VideoMainOne> get dataSink => dataController.sink;
  Stream<VideoMainOne> get dataStream => dataController.stream;

  final eventController = StreamController<ActionVideo>.broadcast();
  StreamSink<ActionVideo> get eventSink => eventController.sink;
  Stream<ActionVideo> get eventStream => eventController.stream;

  BlocVideoApi(token) {
    eventStream.listen((event) async {
      if (event == ActionVideo.View) {
        dataSink.add(await getData(token: token));
      }
    });
  }

  Future<VideoMainOne> getData({
    required String token,
  }) async {
    Response response = await get(
      Uri.parse("https://hansa-lab.ru/api/site/video"),
      headers: {"token": token},
    );
    return VideoMainOne.fromMap(jsonDecode(response.body));
  }
}
