import 'dart:async';
import 'dart:convert';
import 'package:hansa_app/api_models.dart/api_urls.dart';
import 'package:hansa_app/api_models.dart/job_model.dart';
import 'package:http/http.dart';

enum JobEnum { job }

class HasnaJobAPI {
  final eventController = StreamController<JobEnum>.broadcast();
  final streamController = StreamController<JobModel>.broadcast();

  StreamSink<JobEnum> get eventSink => eventController.sink;
  Stream<JobEnum> get eventStream => eventController.stream;
  Stream<JobModel> get stream => streamController.stream;
  StreamSink<JobModel> get sink => streamController.sink;

  HasnaJobAPI() {
    eventStream.listen((event) async {
      if (event == JobEnum.job) {
        sink.add(await getJobs());
      }
    });
  }
  Future<JobModel> getJobs() async {
    Response response = await get(Uri.parse(APIUrls().getJobUrl));
    return JobModel.fromMap(jsonDecode(response.body));
  }
}
