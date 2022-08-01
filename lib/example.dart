import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hansa_app/api_models.dart/country_model.dart';
import 'package:hansa_app/api_services/hansa_country_api.dart';

class LIstCity extends StatefulWidget {
  const LIstCity({Key? key}) : super(key: key);

  @override
  State<LIstCity> createState() => _LIstCityState();
}

class _LIstCityState extends State<LIstCity> {
  final bloc = HansaCountryAPI(1);
  @override
  void initState() {
    // TODO: implement initState
    bloc.eventSink.add(CityEnum.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return StreamBuilder<CountryModel>(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  return Text(snapshot.hasData
                      ? snapshot.data!.data.list[index].name.toString()
                      : 'yoqwwwwwqqqqqqq');
                });
          },
        ),
      ),
    );
  }
}
