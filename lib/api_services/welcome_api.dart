import 'dart:async';
import 'dart:convert';

import 'package:hansa_app/api_models.dart/welcome_model.dart';
import 'package:hansa_app/api_services/api_urls.dart';
import 'package:http/http.dart';

enum WelcomeApiAction { fetch }

class WelcomeApi {
  final dataController = StreamController<List<WelcomeModelData>>.broadcast();
  StreamSink<List<WelcomeModelData>> get dataSink => dataController.sink;
  Stream<List<WelcomeModelData>> get dataStream => dataController.stream;
  final eventController = StreamController<WelcomeApiAction>.broadcast();
  StreamSink<WelcomeApiAction> get eventSink => eventController.sink;
  Stream<WelcomeApiAction> get eventStream => eventController.stream;

  WelcomeApi(token) {
    int i = 0;
    List<WelcomeModelData> list = [];
    eventStream.listen(
      (event) async {
        if (event == WelcomeApiAction.fetch) {
          i++;
          await getWelcome(token: token, i: i).then((value) {
            list += value.data.welcomeModelListData.list;
            dataSink.add(list);
          });
        }
      },
    );
  }

  Future<WelcomeModel> getWelcome({required String token, int i = 0}) async {
    Response response = await get(
      Uri.parse(APIUrls().getWelcomeUrl + i.toString()),
      headers: {"token": token},
    );
    return WelcomeModel.fromMap(jsonDecode(response.body));
  }
}
