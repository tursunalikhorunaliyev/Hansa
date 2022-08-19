import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:hansa_app/api_models.dart/rating_top_model.dart';
import 'package:http/http.dart';

enum RatingEnum { rating }

class BlocRating {
  Future<RatingTopModel> getStores(token) async {
    Response response = await get(
      Uri.parse('https://hansa-lab.ru/api/site/rating-top'),
      headers: {"token": token},
    );
    return RatingTopModel.fromMap(jsonDecode(response.body));
  }
}
