import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:hansa_app/api_models.dart/rating_top_model.dart';
import 'package:http/http.dart';

enum RatingEnum { rating }

class BlocRating {
  final streamController = StreamController<RatingTopModel>.broadcast();
  final eventController = StreamController<RatingEnum>.broadcast();

  Stream<RatingTopModel> get stream => streamController.stream;
  StreamSink<RatingTopModel> get sink => streamController.sink;

  Stream<RatingEnum> get eventStrem => eventController.stream;
  StreamSink<RatingEnum> get eventSink => eventController.sink;

  BlocRating(token) {
    eventStrem.listen((event) async {
      if (event == RatingEnum.rating) {
        sink.add(await getStores(token));
      }
    });
  }

  Future<RatingTopModel> getStores(token) async {
    Response response = await get(
      Uri.parse('https://hansa-lab.ru/api/site/rating-top'),
      headers: {"token": token},
    );

    log(token.toString());
    log(response.statusCode.toString());
    return RatingTopModel.fromMap(jsonDecode(response.body));
  }
}
