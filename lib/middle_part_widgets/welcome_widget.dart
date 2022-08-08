import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/welcome_model.dart';
import 'package:hansa_app/api_services/welcome_api.dart';
import 'package:hansa_app/extra/event_cards.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:video_player/video_player.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    final scroll = ScrollController();
    final isTablet = Provider.of<bool>(context);
    final token = Provider.of<String>(context);
    final welcomeApi = WelcomeApi(token);
    welcomeApi.eventSink.add(WelcomeApiAction.fetch);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: isTablet ? 20 : 9, bottom: isTablet ? 20 : 0),
              child: Text(
                'Добро пожаловать',
                style: GoogleFonts.montserrat(
                    fontSize: isTablet ? 30 : 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff272624)),
              ),
            ),
            StreamBuilder<List<WelcomeModelData>>(
                stream: welcomeApi.dataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.requireData;
                    return SizedBox(
                      height: isTablet ? 877 : 590,
                      width: isTablet ? 800 : 330,
                      child: isTablet
                          ? Expanded(
                              child: NotificationListener(
                                  onNotification: (value) {
                                    welcomeApi.eventSink
                                        .add(WelcomeApiAction.fetch);
                                    return false;
                                  },
                                  child: GridView(
                                    shrinkWrap: true,
                                    controller: scroll,
                                    physics:
                                        const BouncingScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 30,
                                            childAspectRatio: 10 / 8),
                                    children: List.generate(
                                        snapshot.data!.length, (index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5.0),
                                        child: EventCards(
                                          buttonColor:
                                              const Color(0xffff163e),
                                          buttonText: 'Смотреть',
                                          isDate: true,
                                          month: toDateString(snapshot
                                              .data![index].date
                                              .substring(5, 7)),
                                          day: snapshot.data![index].date
                                              .substring(8, 10),
                                          title: data[index].title,
                                          url: data[index].pictureLink,
                                          isFavourite:
                                              data[index].isFavorite,
                                        ),
                                      );
                                    }),
                                  )),
                            )
                          : SmartRefresher(
                              physics: BouncingScrollPhysics(),
                              controller: refreshController,
                              enablePullDown: false,
                              enablePullUp: true,
                              footer: CustomFooter(
                                builder: (context, mode) {
                                  return SizedBox(
                                    height: 50,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.arrow_upward,
                                              color: const Color(0xffff163e),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Показать еще",
                                              style: GoogleFonts.montserrat(
                                                  color:
                                                      const Color(0xff272624)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              onLoading: () {
                                welcomeApi.eventSink
                                    .add(WelcomeApiAction.fetch);
                                refreshController.loadComplete();
                              },
                              child: SingleChildScrollView(
                                controller: scroll,
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: List.generate(
                                    data.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: EventCards(
                                        buttonColor: const Color(0xffff163e),
                                        buttonText: 'Смотреть',
                                        isDate: true,
                                        month: toDateString(snapshot
                                            .data![index].date
                                            .substring(5, 7)),
                                        day: snapshot.data![index].date
                                            .substring(8, 10),
                                        title: data[index].title,
                                        url: data[index].pictureLink,
                                        isFavourite: data[index].isFavorite,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    );
                  } else {
                    welcomeApi.eventSink.add(WelcomeApiAction.fetch);
                    return Center(
                        child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 240),
                      child: Lottie.asset(
                        'assets/pre.json',
                        height: 70,
                        width: 70,
                      ),
                    ));
                  }
                }),
          ],
        ),
      ],
    );
  }

  String toDateString(String m) {
    if (m == "01") {
      return "Январь";
    } else if (m == "02") {
      return "Февраль";
    } else if (m == "03") {
      return "Март";
    } else if (m == "04") {
      return "Апрель";
    } else if (m == "05") {
      return "Май";
    } else if (m == "06") {
      return "Июнь";
    } else if (m == "07") {
      return "Июль";
    } else if (m == "08") {
      return "Август";
    } else if (m == "09") {
      return "Сентябрь";
    } else if (m == "10") {
      return "Октябрь";
    } else if (m == "11") {
      return "Ноябрь";
    } else {
      return "Декабрь";
    }
  }
}
