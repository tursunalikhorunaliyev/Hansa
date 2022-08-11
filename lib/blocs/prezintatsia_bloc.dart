import 'dart:async';
import 'dart:convert';

import 'package:hansa_app/api_models.dart/prezintatsi_model.dart';
import 'package:http/http.dart' as http;

enum PrezintatsiaAction { show }

class PrezintatsiaBLoC {
  final controller = StreamController<PrezintatsiaModel>();
  final controllerAction = StreamController<PrezintatsiaAction>();

  StreamSink<PrezintatsiaAction> get sinkAction => controllerAction.sink;
  Stream<PrezintatsiaAction> get streamAction => controllerAction.stream;
  StreamSink<PrezintatsiaModel> get sink => controller.sink;
  Stream<PrezintatsiaModel> get stream => controller.stream;

  PrezintatsiaBLoC(token) {
    streamAction.listen((event) async {
      if (event == PrezintatsiaAction.show) {
        sink.add(await getPrezintatsiyaData(token));
      }
    });
  }

  Future<PrezintatsiaModel> getPrezintatsiyaData(token) async {
    http.Response response = await http.post(
      Uri.parse("http://hansa-lab.ru/api/site/presentation?id=1"),
      headers: {"token": token},
    );

    print(response.statusCode);
    print(
        "Status Code==========================================================================================");

    return PrezintatsiaModel.fromMap(jsonDecode(response.body));
  }
}
