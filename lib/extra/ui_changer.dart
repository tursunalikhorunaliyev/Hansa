import 'package:flutter/material.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/middle_part_widgets/welcome_widget.dart';
import 'package:hansa_app/middle_part_widgets/katalogi.dart';
import 'package:hansa_app/middle_part_widgets/o_kompanii.dart';
import 'package:hansa_app/middle_part_widgets/o_kompaniya.dart';
import 'package:hansa_app/middle_part_widgets/obucheniya_widget.dart';
import 'package:hansa_app/middle_part_widgets/present_and_achive.dart';
import 'package:hansa_app/middle_part_widgets/stati.dart';
import 'package:hansa_app/middle_part_widgets/treningi.dart';
import 'package:hansa_app/middle_part_widgets/treningi_video.dart';
import 'package:hansa_app/middle_part_widgets/prezentatsi.dart';
import 'package:hansa_app/middle_part_widgets/video.dart';
import 'package:hansa_app/screens/read_stati.dart';
import 'package:provider/provider.dart';

class UIChanger extends StatelessWidget {
  const UIChanger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MenuEventsBloC>(context);
    return StreamBuilder<MenuActions>(
      stream: provider.eventStream,
      initialData: MenuActions.welcome,
      builder: (context, snapshot) {
        if (snapshot.data == MenuActions.welcome) {
          return const WelcomeWidget();
        } else if (snapshot.data == MenuActions.obuchayushieMaterial) {
          return const ObucheniyaWidget();
        } else if (snapshot.data == MenuActions.prezintatsiya) {
          return const Prezentatsi();
        } else if (snapshot.data == MenuActions.trening) {
          return const Treningi();
        } else if (snapshot.data == MenuActions.stati) {
          return const Stati();
        } else if (snapshot.data == MenuActions.katalog) {
          return const Katalogi();
        } else if (snapshot.data == MenuActions.video) {
          return Video();
        } else if (snapshot.data == MenuActions.oProyekt) {
          return const Okompaniya();
        } else if (snapshot.data == MenuActions.presentAndArchive) {
          return const PresentArchive();
        } else if (snapshot.data == MenuActions.chitatStati) {
          return ReadStati();
        } else if (snapshot.data == MenuActions.trainingVideo) {
          return const TreningiVideo();
        } else if (snapshot.data == MenuActions.oKompanii) {
          return const OKompanii();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
