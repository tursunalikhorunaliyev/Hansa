import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:hansa_app/api_models.dart/search_model.dart';
import 'package:hansa_app/enums/search_action.dart';
import 'package:http/http.dart' as http;

class SearchApi {
  final dataController = StreamController<SearchModel>.broadcast();
  final eventController = StreamController<SearchAction>.broadcast();

  StreamSink<SearchModel> get dataSink => dataController.sink;
  Stream<SearchModel> get dataStream => dataController.stream;

  StreamSink<SearchAction> get eventSink => eventController.sink;
  Stream<SearchAction> get eventStream => eventController.stream;

  SearchApi(token, query) {
    eventStream.listen((event) async {
      if (event == SearchAction.search) {
        log("Action completed...");
        dataSink.add(
          await getSearchData(
            token,
            query.toString().isEmpty ? "   " : query,
          ),
        );
      }
    });
  }

  Future<SearchModel> getSearchData(String token, String query) async {
    http.Response response = await http.post(
      Uri.parse('https://hansa-lab.ru/api/site/search'),
      headers: {"token": token},
      body: {"search": query},
    );
    log("Data length in fun ${jsonDecode(response.body)['data'].length}");
    return SearchModel.fromMap(jsonDecode(response.body));
  }
}
