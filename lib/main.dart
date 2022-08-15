import 'package:flutter/material.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hansa_app/api_services/country_type_service.dart';
import 'package:hansa_app/blocs/article_bloc.dart';
import 'package:hansa_app/blocs/bloc_change_profile.dart';
import 'package:hansa_app/blocs/bloc_change_title.dart';
import 'package:hansa_app/blocs/bloc_flip_login.dart';
import 'package:hansa_app/blocs/bloc_play_video.dart';
import 'package:hansa_app/blocs/bloc_video_controll.dart';
import 'package:hansa_app/blocs/download_progress_bloc.dart';
import 'package:hansa_app/blocs/login_clicked_bloc.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/blocs/read_stati_bloc.dart';
import 'package:hansa_app/blocs/voyti_ili_sozdata_bloc.dart';
import 'package:hansa_app/middle_part_widgets/permission_handler_screen.dart';
import 'package:hansa_app/providers/dialog_video_provider.dart';
import 'package:hansa_app/providers/full_registr_provider.dart';
import 'package:hansa_app/providers/new_shop_provider.dart';
import 'package:hansa_app/providers/provider_for_flipping/flip_login_provider.dart';
import 'package:hansa_app/providers/provider_for_flipping/login_clicked_provider.dart';
import 'package:hansa_app/providers/provider_for_flipping/provider_for_flipping.dart';
import 'package:hansa_app/blocs/toggle_switcher_bloc.dart';
import 'package:hansa_app/providers/providers_for_video_title/video_index_provider.dart';
import 'package:hansa_app/providers/providers_for_video_title/video_title_provider.dart';
import 'package:hansa_app/providers/stati_id_provider.dart';
import 'package:hansa_app/providers/treningi_photos_provider.dart';
import 'package:hansa_app/providers/treningi_video_changer_provider.dart';
import 'package:hansa_app/providers/treningi_videos_provider.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await Hive.initFlutter();
  await Hive.openBox("savedUser");
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
          Provider(
            create: (context) => DownloadProgressFileBloc(),
          ),
          ChangeNotifierProvider(create: (context) => StatiIdProvider()),
          ChangeNotifierProvider(
            create: (context) => TreningiVideoChangerProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => NewShopProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FlipProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => LoginClickedProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FlipLoginProvider(),
          ),
          Provider(
            create: (context) => BlocVideoControll(),
          ),
          ChangeNotifierProvider(
            create: (context) => VideoTitleProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => VideoIndexProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => TreningiPhotosProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FullRegisterDataProvider(),
          ),
          Provider(create: (context) => CountryTypeService().getCountryTypes()),
          Provider(create: (context) => ToggleSwitcherBloc()),
          Provider<bool>(create: (context) => isTablet),
          Provider(create: (context) => BlocChangeTitle()),
          Provider(create: (context) => BlocChangeTitleIndex()),
          Provider(create: (context) => map),
          Provider(create: (context) => VoytiIliSozdatBloC()),
          Provider(create: (context) => ReadStatiBLoC()),
          Provider(
            create: (context) => MenuEventsBloC(),
          ),
          Provider(
            create: (context) => ArticleBLoC(),
          ),
          Provider(
            create: (context) => BlocPlayVideo(),
          ),
          Provider(
            create: ((context) => BlocChangeProfile()),
          ),
          Provider(
            create: (context) => LoginClickedBloc(),
          ),
          Provider(create: (context) => BlocFlipLogin()),
          ChangeNotifierProvider(create: (context) => DialogVideoProvider()),
        ],
        child: const MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: [
            const Locale("en"),
            const Locale("ru"),
            const Locale("ar")
          ],
          locale: Locale("ru"),
          debugShowCheckedModeBanner: false,
          home: PermissionHandlerScreen(),
        ),
      ),
    );
  }
}
