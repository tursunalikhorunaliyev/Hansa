import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:hansa_app/api_models.dart/stati_comment_model.dart';

enum StatiComentEnum { coment }

class BlocForStatiComment {
  final streamController = StreamController<StatiComentModel>.broadcast();
  final eventC = StreamController<StatiComentEnum>.broadcast();
  Stream<StatiComentModel> get stream => streamController.stream;
  StreamSink<StatiComentModel> get sink => streamController.sink;
  Stream<StatiComentEnum> get evstream => eventC.stream;
  StreamSink<StatiComentEnum> get evsink => eventC.sink;

  BlocForStatiComment(id, token) {
    evstream.listen((event) async {
      if (event == StatiComentEnum.coment) {
        sink.add(await getComment(id, token));
      }
    });
  }

  Future<StatiComentModel> getComment(id, token) async {
    Map<String, String> headers = {'token': token};
    http.Response response = await http.get(
        Uri.parse('http://hansa-lab.ru/api/site/messages?id=$id'),
        headers: headers);
    return StatiComentModel.fromMap(jsonDecode(response.body));
  }
}
