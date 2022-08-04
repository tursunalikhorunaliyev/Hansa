import 'dart:async';
import 'dart:convert';

import 'package:hansa_app/api_models.dart/model_personal.dart';
import 'package:hansa_app/enums/enum_action_view.dart';
import 'package:http/http.dart' as http;

class BlocPersonal {
  final dataController = StreamController<ModelPersonalMain>();
  final eventController = StreamController<EnumActionView>();

  StreamSink<ModelPersonalMain> get dataSink => dataController.sink;
  Stream<ModelPersonalMain> get dataStream => dataController.stream;

  StreamSink<EnumActionView> get eventSink => eventController.sink;
  Stream<EnumActionView> get eventStream => eventController.stream;

  BlocPersonal(token) {
    eventStream.listen((event) async {
      if (event == EnumActionView.view) {
        dataSink.add(await getData(token));
      }
    });
  }

  Future<ModelPersonalMain> getData(token) async {
    http.Response response = await http.get(
      Uri.parse("https://hansa-lab.ru/api/site/account"),
      headers: {"token": token},
    );
    print(response.statusCode);
    print(response.body);
    print("Bloc Personal----------------------------------");

    return ModelPersonalMain.fromMap(jsonDecode(response.body));
  }
}
