import 'dart:async';
import 'dart:convert';

import 'package:hansa_app/api_models.dart/model_personal.dart';
import 'package:hansa_app/enums/enum_action_view.dart';
import 'package:http/http.dart' as http;

class BlocPersonal {
  Future<ModelPersonalMain> getData(token) async {
    http.Response response = await http.get(
      Uri.parse("https://hansa-lab.ru/api/site/account"),
      headers: {"token": token},
    );
    print(response.statusCode);
    print(response.body);
    print("Bloc Personal----------------------------------");

    return ModelPersonalMain.fromMap(jsonDecode(response.body));
  }
}
