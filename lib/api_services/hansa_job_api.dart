import 'dart:async';
import 'dart:convert';
import 'package:hansa_app/api_services/api_urls.dart';
import 'package:hansa_app/api_models.dart/job_model.dart';
import 'package:http/http.dart';

enum JobEnum { job }

class BlocJob {
  final streamController = StreamController<List<String>>.broadcast();
  final eventController = StreamController<JobEnum>.broadcast();

  Stream<List<String>> get stream => streamController.stream;
  StreamSink<List<String>> get sink => streamController.sink;

  Stream<JobEnum> get eventStrem => eventController.stream;
  StreamSink<JobEnum> get eventSink => eventController.sink;

  BlocJob() {
    eventStrem.listen((event) async {
      if (event == JobEnum.job) {
        sink.add(await getJobs());
      }
    });
  }
  Future<List<String>> getJobs() async {
    Response response = await get(Uri.parse(APIUrls().getJobUrl));
    return JobModel.fromMap(jsonDecode(response.body)).data.jobs;
  }
}
