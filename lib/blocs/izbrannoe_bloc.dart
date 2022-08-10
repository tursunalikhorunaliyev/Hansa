import 'dart:async';
import 'dart:convert';
import 'package:hansa_app/api_models.dart/izbrannoe_model.dart';
import 'package:hansa_app/enums/enum_action_view.dart';
import 'package:http/http.dart' as http;

enum IzbrannoeAction { show }

class IzbrannoeBLoC {
  final dataController = StreamController<IzbrannoeModel>();
  final eventController = StreamController<IzbrannoeAction>();

  StreamSink<IzbrannoeModel> get dataSink => dataController.sink;
  Stream<IzbrannoeModel> get dataStream => dataController.stream;

  StreamSink<IzbrannoeAction> get eventSink => eventController.sink;
  Stream<IzbrannoeAction> get eventStream => eventController.stream;

  IzbrannoeBLoC(token) {
    eventStream.listen((event) async {
      if (event == IzbrannoeAction.show) {
        dataSink.add(await getData(token));
      }
    });
  }

  Future<IzbrannoeModel> getData(token) async {
    http.Response response = await http.post(
      Uri.parse("https://hansa-lab.ru/api/site/favouriete"),
      headers: {"token": token},
    );
    print(response.statusCode);
    print(response.body);

    return IzbrannoeModel.fromMap(jsonDecode(response.body));
  }
}
