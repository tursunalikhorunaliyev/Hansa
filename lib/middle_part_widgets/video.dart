import 'package:flutter/material.dart';
import 'package:hansa_app/blocs/bloc_change_title.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/extra/custom_title.dart';
import 'package:hansa_app/video_section/custom_video_item.dart';
import 'package:hansa_app/video_section/custom_video_subitem.dart';
import 'package:provider/provider.dart';

class Video extends StatelessWidget {
  Video({Key? key}) : super(key: key);
  final List<String> titles = [
    "О компании",
    "Обучающие",
    "Варочные поверхности",
    "Духовые шкафы"
  ];

  @override
  Widget build(BuildContext context) {
    final menuEventsBloCProvider = Provider.of<MenuEventsBloC>(context);
    final blocChangeTitleProvider = Provider.of<BlocChangeTitle>(context);
    return Expanded(
      child: Column(
        children: [
          const CustomTitle(
            imagePath: "assets/video_title.png",
            title: "Видео",
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                  children: List.generate(4, (index) {
                return Column(
                  children: [
                    CustomVideoSubItem(onTap: () {
                      blocChangeTitleProvider.titleSink.add(titles[index]);
                      menuEventsBloCProvider.eventSink.add(MenuActions.oKompanii);
                    },title: titles[index]),
                    SizedBox(
                      height: 235,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: 15,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                EdgeInsets.only(left: (index == 0) ? 30 : 0),
                            child: GestureDetector(
                                onTap: () {},
                                child: const CustomVideoListItem()),
                          );
                        },
                      ),
                    ),
                  ],
                );
              })),
            ),
          ),
        ],
      ),
    );
  }
}
