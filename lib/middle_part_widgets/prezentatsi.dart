import 'package:flutter/material.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/extra/custom_appbar.dart';
import 'package:hansa_app/extra/custom_bottom_bar.dart';
import 'package:hansa_app/extra/custom_clip_item.dart';
import 'package:hansa_app/presentation_section/custom_prezentatsi_item.dart';
import 'package:hansa_app/extra/custom_title.dart';
import 'package:provider/provider.dart';

class Prezentatsi extends StatefulWidget {
  const Prezentatsi({Key? key}) : super(key: key);

  @override
  State<Prezentatsi> createState() => _PrezentatsiState();
}

class _PrezentatsiState extends State<Prezentatsi> {
  @override
  Widget build(BuildContext context) {
    final menuBloCProvider = Provider.of<MenuEventsBloC>(context);
    return Expanded(
      child: Column(
        children: [
          const CustomTitle(
            imagePath: "assets/prezentatsi_title.png",
            title: "Презентации",
          ),
          Expanded(
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    15,
                    (index) => CustomClipItem(
                      backgroundColor: const Color(0xffffffff),
                      buttonTextColor: const Color(0xffffffff),
                      buttonColor: const Color(0xffe21a37),
                      titleColor: const Color(0xff272624),
                      title: !(index % 2 == 0)
                          ? "5 новинок из линейки\nстиральных машин Ultimate"
                          : "Обучающий материал для\nсотрудников Леруа Мерлен",
                      buttonText: "Читать",
                      onTap: (){
                        
                        menuBloCProvider.eventSink.add(MenuActions.presentAndArchive);
                      },
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
