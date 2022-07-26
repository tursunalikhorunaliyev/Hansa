import 'package:flutter/material.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/training_section/custom_calendar.dart';
import 'package:hansa_app/extra/custom_clip_item.dart';
import 'package:hansa_app/extra/custom_title.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';

class Treningi extends StatefulWidget {
  const Treningi({Key? key}) : super(key: key);

  @override
  State<Treningi> createState() => _TreningiState();
}

class _TreningiState extends State<Treningi> {
  @override
  Widget build(BuildContext context) {
    final menuBloCProvider =  Provider.of<MenuEventsBloC>(context);
    return  Expanded(
      child: Column(
            children: [
             
              Expanded(
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
                            const CustomCalendar(),
                             CustomClipItem(
                              backgroundColor:const  Color(0xffff163e),
                              buttonColor:const   Color(0xff232323),
                              buttonTextColor:const Color(0xffffffff),
                              titleColor:const  Color(0xffffffff),
                              buttonText: "Записаться",
                              title: "Иммерсивное шоу\n\"Увидимся на кухне\"",
                              onTap: (){},
                            ),
                          ],
                        ),
                      ),
                      StickyHeader(
                        header: const CustomTitle(
                          imagePath: "assets/kak_title.png",
                          title: "Как это было",
                        ),
                        content: Column(
                          children: List.generate(
                            15,
                            (index) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                CustomClipItem(
                                  backgroundColor: const Color(0xff000004),
                                  buttonColor:const Color(0xffe21a37),
                                  buttonTextColor:const Color(0xffffffff),
                                  titleColor:const Color(0xffffffff),
                                  buttonText: "Смотреть",
                                  title: "Иммерсивное шоу\n\"Увидимся на кухне\"",
                                  onTap: (){
                                    menuBloCProvider.eventSink.add(MenuActions.trainingVideo);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
