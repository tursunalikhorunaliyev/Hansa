import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hansa_app/api_models.dart/training_model.dart';

enum TrainingAPIEvent { fetch }

class TrainingAPIBloc {
  final dataController = StreamController<TrainingModel>.broadcast();
  StreamSink<TrainingModel> get dataSink => dataController.sink;
  Stream<TrainingModel> get dataStream => dataController.stream;

  final eventController = StreamController<TrainingAPIEvent>.broadcast();
  StreamSink<TrainingAPIEvent> get eventSink => eventController.sink;
  Stream<TrainingAPIEvent> get eventStream => eventController.stream;

  TrainingAPIBloc(token) {
    eventStream.listen((event) async {
      if (event == TrainingAPIEvent.fetch) {
        dataSink.add(await getTrainingData(token));
      }
    });
  }

  Future<TrainingModel> getTrainingData(token) async {
    http.Response response = await http.get(
      Uri.parse("https://hansa-lab.ru/api/site/training"),
      headers: {"token": token},
    );
    return TrainingModel.fromMap(jsonDecode(response.body));
  }
}
