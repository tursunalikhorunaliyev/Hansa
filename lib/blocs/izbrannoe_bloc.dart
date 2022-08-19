import 'dart:async';
import 'dart:convert';
import 'package:hansa_app/api_models.dart/izbrannoe_model.dart';
import 'package:http/http.dart' as http;

enum IzbrannoeAction { show }

class IzbrannoeBLoC {
  Future<IzbrannoeModel> getData(token) async {
    http.Response response = await http.post(
      Uri.parse("https://hansa-lab.ru/api/site/favouriete"),
      headers: {"token": token},
    );
    print(response.statusCode);
    print(response.body);

    return IzbrannoeModel.fromMap(jsonDecode(response.body));
  }
}
