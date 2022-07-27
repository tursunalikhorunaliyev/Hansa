import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hansa_app/blocs/bloc_change_profile.dart';
import 'package:hansa_app/blocs/bloc_change_title.dart';
import 'package:hansa_app/blocs/bloc_play_video.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/blocs/voyti_ili_sozdata_bloc.dart';
import 'package:hansa_app/screens/hansa_zagruzka.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    Size size = WidgetsBinding.instance.window.physicalSize;
    bool isTablet = (size.width / 3) > 500;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MultiProvider(
        providers: [
          Provider<bool>(create: (context) => isTablet),
          Provider(create: (context) => BlocChangeTitle()),
          Provider(create: (context) => FlipCardController()),
          Provider(create: (context) => VoytiIliSozdatBloC()),
          Provider(
            create: (context) => MenuEventsBloC(),
          ),
          Provider(
            create: (context) => scaffoldKey,
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
