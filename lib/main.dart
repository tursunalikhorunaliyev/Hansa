import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hansa_app/api_models.dart/job_model.dart';
import 'package:hansa_app/api_models.dart/store_model.dart';
import 'package:hansa_app/api_services/country_type_service.dart';
import 'package:hansa_app/api_services/hansa_country_api.dart';
import 'package:hansa_app/api_services/hansa_job_api.dart';
import 'package:hansa_app/api_services/store_service.dart';
import 'package:hansa_app/blocs/bloc_change_profile.dart';
import 'package:hansa_app/blocs/bloc_change_title.dart';
import 'package:hansa_app/blocs/bloc_play_video.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/blocs/voyti_ili_sozdata_bloc.dart';
import 'package:hansa_app/screens/hansa_zagruzka.dart';
import 'package:hansa_app/blocs/toggle_switcher_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("loginHansa");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = WidgetsBinding.instance.window.physicalSize;

    bool isTablet = (size.width / 3) > 500;

    Map<String, FlipCardController> map = {
      "login": FlipCardController(),
      "signin": FlipCardController()
    };
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MultiProvider(
        providers: [
          Provider(create: (context) => StoreData().getStores(),),
          Provider(create: (context) => HasnaJobAPI().getJobs(),),
          Provider(create: (context) => HansaCountryAPI().getCountries(),),
          Provider(create: (context) => CountryTypeService().getCountryTypes()),
          Provider(create: (context) => ToggleSwitcherBloc()),
          Provider<bool>(create: (context) => isTablet),
          Provider(create: (context) => BlocChangeTitle()),
          Provider(create: (context) => map),
          Provider(create: (context) => VoytiIliSozdatBloC()),
          Provider(
            create: (context) => MenuEventsBloC(),
          ),
          Provider(
            create: (context) => BlocPlayVideo(),
          ),
          Provider(
            create: ((context) => BlocChangeProfile()),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HansaZagruzka(),
        ),
      ),
    );
  }
}
