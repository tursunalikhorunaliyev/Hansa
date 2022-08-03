import 'dart:async';
import 'dart:convert';

import 'package:hansa_app/api_models.dart/read_stati_model.dart';
import 'package:http/http.dart' as http;

enum ReadStatiAction { show }

class ReadStatiBLoC {
  final controller = StreamController<ReadStatiModel>();
  final eventController = StreamController<ReadStatiAction>();

  Stream<ReadStatiModel> get stream => controller.stream;
  StreamSink<ReadStatiModel> get sink => controller.sink;
  Stream<ReadStatiAction> get eventStream => eventController.stream;
  StreamSink<ReadStatiAction> get eventSink => eventController.sink;

  ReadStatiBLoC(token, url) {
    eventStream.listen((event) async {
      if (event == ReadStatiAction.show) {
        sink.add(await getReadStati(token, url));
      }
    });
  }

  Future<ReadStatiModel> getReadStati(token, url) async {
    var headers = {'token': token.toString()};
    var request = http.Request(
        'GET', Uri.parse("https://hansa-lab.ru/" + url.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    Map<String, dynamic>? map;
    if (response.statusCode == 200) {
      await response.stream
          .bytesToString()
          .then((value) => map = jsonDecode(value) as Map<String, dynamic>);
    }

    return ReadStatiModel.fromMap(map!);
  }
}
