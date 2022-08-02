import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/drawer_widgets/text_icon.dart';
import 'package:provider/provider.dart';

class TextIconCard extends StatelessWidget {
  const TextIconCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final munuchangerProvider = Provider.of<MenuEventsBloC>(context);
    final scafforlKeyProvider = Provider.of<GlobalKey<ScaffoldState>>(context);
    final isTablet = Provider.of<bool>(context);
    return Column(
      children: [
        InkWell(
          onTap: () {
            munuchangerProvider.eventSink.add(MenuActions.obuchayushieMaterial);
            scafforlKeyProvider.currentState!.closeDrawer();
          },
          child: InkWell(
            onTap: () {
               munuchangerProvider.eventSink.add(MenuActions.welcome);
            scafforlKeyProvider.currentState!.closeDrawer();
            },
            child: Row(
              children: [
               
                 Icon(CupertinoIcons.home, color: Color.fromARGB(255, 221, 221, 221),),
             SizedBox(width: 20,),
              Text("Home",style: GoogleFonts.montserrat(fontSize: isTablet ? 20  : 13, color: Colors.white),),
              ],
            ),
          )
        ),
        const SizedBox(
          height: 15,
        ),
        InkWell(
          onTap: () {
            munuchangerProvider.eventSink.add(MenuActions.obuchayushieMaterial);
            scafforlKeyProvider.currentState!.closeDrawer();
          },
          child: TextIcon(
            text: "Обучающие материалы",
            iconUrl: "assets/free-icon-academic-2599288.png",
          ),
        ),
        SizedBox(
          height: isTablet ? 30 : 20,
        ),
        InkWell(
          onTap: () {
            munuchangerProvider.eventSink.add(MenuActions.prezintatsiya);
            scafforlKeyProvider.currentState!.closeDrawer();
          },
          child: TextIcon(
            text: "Презентации",
            iconUrl: "assets/free-icon-presentation-582644.png",
          ),
        ),
        SizedBox(
          height: isTablet ? 30 : 20,
        ),
        InkWell(
          onTap: () {
            munuchangerProvider.eventSink.add(MenuActions.stati);
            scafforlKeyProvider.currentState!.closeDrawer();
          },
          child: TextIcon(
            text: "Статьи",
            iconUrl: "assets/free-icon-article-1738703 (1).png",
          ),
        ),
        SizedBox(
          height: isTablet ? 30 : 20,
        ),
        InkWell(
          onTap: () {
            munuchangerProvider.eventSink.add(MenuActions.katalog);
            scafforlKeyProvider.currentState!.closeDrawer();
          },
          child: TextIcon(
            text: "Каталоги",
            iconUrl: "assets/free-icon-catalogue-5116518.png",
          ),
        ),
        SizedBox(
          height: isTablet ? 30 : 20,
        ),
        InkWell(
          onTap: () {
            munuchangerProvider.eventSink.add(MenuActions.trening);
            scafforlKeyProvider.currentState!.closeDrawer();
          },
          child: TextIcon(
            text: "Тренинги",
            iconUrl: "assets/free-icon-online-learning-2374323.png",
          ),
        ),
        SizedBox(
          height: isTablet ? 30 : 20,
        ),
        InkWell(
          onTap: () {
            munuchangerProvider.eventSink.add(MenuActions.video);
            scafforlKeyProvider.currentState!.closeDrawer();
          },
          child: TextIcon(
            text: "Видео",
            iconUrl: "assets/free-icon-video-1500440.png",
          ),
        ),
        SizedBox(
          height: isTablet ? 30 : 20,
        ),
        InkWell(
          onTap: () {
            munuchangerProvider.eventSink.add(MenuActions.oProyekt);
            scafforlKeyProvider.currentState!.closeDrawer();
          },
          child: TextIcon(
            text: "О проекте",
            iconUrl: "assets/free-icon-information-157933.png",
          ),
        ),
      ],
    );
  }
}
