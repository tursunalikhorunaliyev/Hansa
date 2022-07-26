import 'package:flutter/material.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/extra/custom_clip_item.dart';
import 'package:hansa_app/extra/custom_title.dart';
import 'package:hansa_app/training_section/custom_treningi_video.dart';
import 'package:hansa_app/training_video_section/custom_treningi_photos.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class TreningiVideo extends StatelessWidget {
  const TreningiVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Expanded(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              StickyHeader(
                header: const CustomTitle(
                  imagePath: "assets/treningi_title.png",
                  title: "Тренинги",
                ),
                content: Column(
                  children: [
                    Row(),
                    const CustomTreningiPhotos(),
                    CustomTreningiVideo(),
                  ],
                ),
              ),
              StickyHeader(
                header: const CustomTitle(
                  imagePath: "assets/kak_title.png",
                  title: "Похожие мероприятия",
                ),
                content: Column(
                  children: List.generate(
                    15,
                    (index) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        CustomClipItem(
                          onTap:(){
                            
                          },
                          backgroundColor: const Color(0xff000004),
                          buttonColor: const Color(0xffe21a37),
                          buttonTextColor: const Color(0xffffffff),
                          titleColor: const Color(0xffffffff),
                          buttonText: "Смотреть",
                          title:
                              "Иммерсивное шоу \"Увидимся\nна кухне\" г. Санкт-Петербург:\n06/06/2",
                      
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
