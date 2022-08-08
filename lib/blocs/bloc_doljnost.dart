import 'dart:async';
import 'dart:convert';

import 'package:hansa_app/api_models.dart/model_doljnost.dart';
import 'package:hansa_app/blocs/bloc_magazin.dart';
import 'package:hansa_app/enums/enum_action_view.dart';
import 'package:http/http.dart' as http;


class BlocDoljnost {
  final dataController = StreamController<ModelDoljnostMain>();
  final eventController = StreamController<EnumActionView>();

  StreamSink<ModelDoljnostMain> get dataSink => dataController.sink;
  Stream<ModelDoljnostMain> get dataStream => dataController.stream;

  StreamSink<EnumActionView> get eventSink => eventController.sink;
  Stream<EnumActionView> get eventStream => eventController.stream;

    BlocDoljnost(token) {
    eventStream.listen((event) async {
      if (event == EnumActionView.view){
        dataSink.add(await getData(token));
      }
    });
  }

    Future<ModelDoljnostMain> getData(token) async {
    http.Response response = await http.get(
      Uri.parse("https://hansa-lab.ru/api/dictionary/job"),
      headers: {"token": token},
    );
    print(response.statusCode);
    print(response.body);
    print("Bloc Doljnost----------------------------------");

    return ModelDoljnostMain.fromMap(jsonDecode(response.body));
  }
}