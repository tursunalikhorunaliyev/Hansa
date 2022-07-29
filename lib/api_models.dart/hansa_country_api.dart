import 'dart:async';
import 'dart:convert';
import 'package:hansa_app/api_models.dart/api_urls.dart';
import 'package:hansa_app/api_models.dart/country_model.dart';
import 'package:hansa_app/api_models.dart/country_type_model.dart';
import 'package:http/http.dart';

enum CountryEnum { country }

class HansaCountryAPI {
  final eventController = StreamController<CountryEnum>.broadcast();
  final streamController = StreamController<CountryModel>.broadcast();

  StreamSink<CountryEnum> get eventSink => eventController.sink;
  Stream<CountryEnum> get eventStream => eventController.stream;
  Stream<CountryModel> get stream => streamController.stream;
  StreamSink<CountryModel> get sink => streamController.sink;

  HansaCountryAPI() {
    eventStream.listen((event) async {
      if (event == CountryEnum.country) {
        sink.add(await getCountries());
      }
    });
  }
  Future<CountryModel> getCountries() async {
    Response response = await get(Uri.parse(APIUrls().getCountries));
    return CountryModel.fromMap(jsonDecode(response.body));
  }
}
