import 'dart:convert';
import 'package:hansa_app/api_models.dart/api_urls.dart';
import 'package:hansa_app/api_models.dart/store_model.dart';
import 'package:http/http.dart';

class HansaStoreAPI {
  Future<StoreModel> getStores() async {
    Response response = await get(Uri.parse(APIUrls().getStoreUrl));
    return StoreModel.fromMap(jsonDecode(response.body));
  }
}
