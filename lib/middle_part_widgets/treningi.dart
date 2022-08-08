import 'package:flutter/material.dart';
import 'package:hansa_app/api_models.dart/training_model.dart';
import 'package:hansa_app/api_services/training_api_bloc.dart';
import 'package:hansa_app/api_services/welcome_api.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/extra/custom_tablet_item.dart';
import 'package:hansa_app/extra/custom_treningi_ipad_container.dart';
import 'package:hansa_app/training_section/custom_calendar.dart';
import 'package:hansa_app/extra/custom_clip_item.dart';
import 'package:hansa_app/extra/custom_title.dart';
import 'package:lottie/lottie.dart';
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
    final menuBloCProvider = Provider.of<MenuEventsBloC>(context);
    final isTablet = Provider.of<bool>(context);
    final token = Provider.of<String>(context);
    final trainingBloc = TrainingAPIBloc(token);
    trainingBloc.eventSink.add(TrainingAPIEvent.fetch);

    final scroll = ScrollController();
    final welcomeApi = WelcomeApi(token);
    welcomeApi.eventSink.add(WelcomeApiAction.fetch);
    return Expanded(
      child: SingleChildScrollView(
        child: StreamBuilder<TrainingModel>(
            stream: trainingBloc.dataStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!.data;
                return Column(
                  children: [
                    StickyHeader(
                      header: const CustomTitle(
                        imagePath: "assets/treningi_title.png",
                        title: "Тренинги",
                      ),
                      content: Column(
                        children: [
                          Row(),
                          CustomCalendar(
                              dates: snapshot.data!.data.events.events),
                          isTablet
                              ? const IpadContainer()
                              : CustomClipItem(
                                  backgroundColor: const Color(0xffff163e),
                                  buttonColor: const Color(0xff232323),
                                  buttonTextColor: const Color(0xffffffff),
                                  titleColor: const Color(0xffffffff),
                                  buttonText: "Записаться",
                                  title:
                                      "Иммерсивное шоу\n\"Увидимся на кухне\"",
                                  onTap: () {},
                                ),
                        ],
                      ),
                    ),
                    StickyHeader(
                      header: const CustomTitle(
                        imagePath: "assets/kak_title.png",
                        title: "Как это было",
                      ),
                      content: Builder(builder: (context) {
                        if (isTablet) {
                          return NotificationListener(
                              onNotification: (value) {
                                welcomeApi.eventSink
                                    .add(WelcomeApiAction.fetch);
                                return false;
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 35),
                                child: GridView(
                                  controller: scroll,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 30,
                                          childAspectRatio: 3.1),
                                  children: List.generate(
                                      snapshot.data!.data.eventReports.list
                                          .length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: TabletItemTreningi(
                                        backgroundColor:
                                            const Color(0xff000004),
                                        buttonColor: const Color(0xffe21a37),
                                        buttonTextColor:
                                            const Color(0xffffffff),
                                        titleColor: const Color(0xffffffff),
                                        buttonText: "Смотреть",
                                        title: data.futureEvents.list[0].title,
                                        onTap: () {
                                          menuBloCProvider.eventSink
                                              .add(MenuActions.trainingVideo);
                                        },
                                      ),
                                    );
                                  }),
                                ),
                              ));
                        } else {
                          return Column(
                            children: List.generate(
                              data.eventReports.list.length,
                              (index) {
                                return CustomClipItem(
                                  backgroundColor: const Color(0xff000004),
                                  buttonColor: const Color(0xffe21a37),
                                  buttonTextColor: const Color(0xffffffff),
                                  titleColor: const Color(0xffffffff),
                                  buttonText: "Смотреть",
                                  title: data.eventReports.list[index].title,
                                  onTap: () {
                                    menuBloCProvider.eventSink
                                        .add(MenuActions.trainingVideo);
                                  },
                                );
                              },
                            ),
                          );
                        }
                      }),
                    ),
                  ],
                );
              } else {
                return Padding(
                  padding: EdgeInsets.only(
                      top: (MediaQuery.of(context).size.height / 2) - 135),
                  child: Center(
                    child: Lottie.asset(
                      'assets/pre.json',
                      height: 70,
                      width: 70,
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
