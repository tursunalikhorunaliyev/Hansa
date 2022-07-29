import 'dart:async';
import 'dart:convert';
import 'package:hansa_app/api_models.dart/api_urls.dart';
import 'package:hansa_app/api_models.dart/store_model.dart';
import 'package:http/http.dart';

enum StoreEnum { store }

class HansaStoreAPI {
  final eventController = StreamController<StoreEnum>.broadcast();
  final streamController = StreamController<StoreModel>.broadcast();

  StreamSink<StoreEnum> get eventSink => eventController.sink;
  Stream<StoreEnum> get eventStream => eventController.stream;
  Stream<StoreModel> get stream => streamController.stream;
  StreamSink<StoreModel> get sink => streamController.sink;

  HansaStoreAPI() {
    eventStream.listen((event) async {
      if (event == StoreEnum.store) {
        sink.add(await getStores());
      }
    });
  }

  Future<StoreModel> getStores() async {
    Response response = await get(Uri.parse(APIUrls().getStoreUrl));
    return StoreModel.fromMap(jsonDecode(response.body));
  }
}
