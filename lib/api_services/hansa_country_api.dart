import 'dart:async';
import 'dart:convert';
import 'package:hansa_app/api_services/api_urls.dart';
import 'package:hansa_app/api_models.dart/country_model.dart';
import 'package:http/http.dart';



class HansaCountryAPI {
 
  Future<List> getCountries() async {
    Response response = await get(Uri.parse(APIUrls().getCountries));
    return CountryModel.fromMap(jsonDecode(response.body)).data.countries;
  }
}
