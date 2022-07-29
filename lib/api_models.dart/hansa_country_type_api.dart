import 'dart:async';
import 'dart:convert';
import 'package:hansa_app/api_models.dart/api_urls.dart';
import 'package:hansa_app/api_models.dart/country_type_model.dart';
import 'package:http/http.dart';

class HansaCountryTypeAPI {
  final controller = StreamController<dynamic>();
  StreamSink<dynamic> get titleSink => controller.sink;
  Stream<dynamic> get titleStream => controller.stream;

  Future<CountryTypeModel> getCountryTypes() async {
    Response response = await get(Uri.parse(APIUrls().getCountryTypes));
    return CountryTypeModel.fromMap(jsonDecode(response.body));
  }
}
