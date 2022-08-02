import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:hansa_app/api_models.dart/country_model.dart';
import 'package:http/http.dart';

enum CityEnum { city }

class HansaCountryBloC {
  final streamController = StreamController<CountryModel>.broadcast();
  final eventController = StreamController<CityEnum>.broadcast();

  Stream<CountryModel> get stream => streamController.stream;
  StreamSink<CountryModel> get sink => streamController.sink;

  Stream<CityEnum> get eventStrem => eventController.stream;
  StreamSink<CityEnum> get eventSink => eventController.sink;

  HansaCountryBloC(id) {
    eventStrem.listen((event) async {
      if (event == CityEnum.city) {
        sink.add(await getCountries(id));
      }
    });
  }

  Future<CountryModel> getCountries(id) async {
    Response response =
        await get(Uri.parse("http://hansa-lab.ru/api/dictionary/city?id=$id"));
    return CountryModel.fromMap(jsonDecode(response.body));
  }
}
