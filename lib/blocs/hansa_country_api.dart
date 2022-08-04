import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:hansa_app/api_models.dart/country_model.dart';
import 'package:hive/hive.dart';
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
      int i = 0;
      if (i == 0) {
        await getCountries(id);
        ++i;
      }
      if (event == CityEnum.city) {
        sink.add(CountryModel.fromMap(Hive.box("cache").get("cities")));
      }
    });
  }

  getCountries(id) async {
    Response response =
        await get(Uri.parse("http://hansa-lab.ru/api/dictionary/city?id=$id"));
    Hive.box("cache").put("cities", jsonDecode(response.body));
  }
}
