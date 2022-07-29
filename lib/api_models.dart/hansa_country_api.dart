import 'dart:convert';
import 'package:hansa_app/api_models.dart/api_urls.dart';
import 'package:hansa_app/api_models.dart/country_model.dart';
import 'package:http/http.dart';

class HansaCountryAPI {
  Future<CountryModel> getCountryTypes() async {
    Response response = await get(Uri.parse(APIUrls().getCountries));
    return CountryModel.fromMap(jsonDecode(response.body));
  }
}
