import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:hansa_app/api_services/api_urls.dart';
import 'package:hansa_app/api_models.dart/job_model.dart';
import 'package:http/http.dart';

enum JobEnum { job }

class BlocJob {
  final streamController = StreamController<JobModel>.broadcast();
  final eventController = StreamController<JobEnum>.broadcast();

  Stream<JobModel> get stream => streamController.stream;
  StreamSink<JobModel> get sink => streamController.sink;

  Stream<JobEnum> get eventStrem => eventController.stream;
  StreamSink<JobEnum> get eventSink => eventController.sink;

  BlocJob() {
    eventStrem.listen((event) async {
      if (event == JobEnum.job) {
        sink.add(await getJobs());
      }
    });
  }
  Future<JobModel> getJobs() async {
    Response response = await get(Uri.parse(APIUrls().getJobUrl));
    print(response.statusCode);
    log(response.body);
    log("Hansa Job-----------------");
    return JobModel.fromMap(jsonDecode(response.body));
  }
}
