import 'dart:convert';
import 'package:hansa_app/api_models.dart/api_urls.dart';
import 'package:hansa_app/api_models.dart/job_model.dart';
import 'package:http/http.dart';

class HasnaJobAPI {
  Future<JobModel> getJobs() async {
    Response response = await get(Uri.parse(APIUrls().getJobUrl));
    return JobModel.fromMap(jsonDecode(response.body));
  }
}
