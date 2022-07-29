import 'dart:async';
import 'dart:convert';
import 'package:hansa_app/api_models.dart/api_urls.dart';
import 'package:hansa_app/api_models.dart/country_type_model.dart';
import 'package:http/http.dart';

enum CountryTypeEnum { countryType }

class HansaCountryTypeAPI {
  final eventController = StreamController<CountryTypeEnum>.broadcast();
  final dataController = StreamController<CountryTypeModel>.broadcast();
  StreamSink<CountryTypeModel> get dataSink => dataController.sink;
  Stream<CountryTypeModel> get dataStream => dataController.stream;
  StreamSink<CountryTypeEnum> get eventSink => eventController.sink;
  Stream<CountryTypeEnum> get eventStream => eventController.stream;

  HansaCountryTypeAPI() {
    eventStream.listen((event) async {
      if (event == CountryTypeEnum.countryType) {
        dataSink.add(await getCountryTypes());
      }
    });
  }

  Future<CountryTypeModel> getCountryTypes() async {
    Response response = await get(Uri.parse(APIUrls().getCountryTypes));
    return CountryTypeModel.fromMap(jsonDecode(response.body));
  }
}
