import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:hansa_app/api_models.dart/treningi_video_model.dart';
import 'package:hansa_app/enums/treningi_video_enum.dart';

class TreningiVideoApi {
  final dataController = StreamController<TreningiVideoModel>();
  final eventController = StreamController<TrVideoEnum>();
  StreamSink<TreningiVideoModel> get dataSink => dataController.sink;
  StreamSink<TrVideoEnum> get eventSink => eventController.sink;
  Stream<TreningiVideoModel> get dataStream => dataController.stream;
  Stream<TrVideoEnum> get eventStream => eventController.stream;
  TreningiVideoApi(url) {
    eventStream.listen((event) async {
      if (event == TrVideoEnum.fetch) {
        dataSink.add(await getTreningiVideo(url));
      }
    });
  }

  Future<TreningiVideoModel> getTreningiVideo(url) async {
    http.Response response =
        await http.get(Uri.parse("https://hansa-lab.ru/${url}"));
    return TreningiVideoModel.fromMap(jsonDecode(response.body));
  }
}
