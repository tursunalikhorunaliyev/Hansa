import 'package:flutter/material.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/extra/custom_clip_item.dart';
import 'package:hansa_app/extra/custom_title.dart';
import 'package:provider/provider.dart';

class Stati extends StatelessWidget {
  const Stati({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statiBloCProvider = Provider.of<MenuEventsBloC>(context);
    return Expanded(
      child: Column(
        children: [
          const CustomTitle(
            imagePath: "assets/stati_title.png",
            title: "Статьи",
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
                    onTap: () {
                      statiBloCProvider.eventSink.add(MenuActions.chitatStati);
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
