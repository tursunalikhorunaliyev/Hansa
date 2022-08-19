import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/training_model.dart';
import 'package:hansa_app/api_services/training_api_bloc.dart';
import 'package:hansa_app/api_services/welcome_api.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/drawer_widgets/izbrannoe.dart';
import 'package:hansa_app/extra/custom_tablet_item.dart';
import 'package:hansa_app/extra/custom_treningi_ipad_container.dart';
import 'package:hansa_app/providers/is_video_provider.dart';
import 'package:hansa_app/providers/treningi_photos_provider.dart';
import 'package:hansa_app/providers/treningi_videos_provider.dart';
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
    final treningiPhotos = Provider.of<TreningiPhotosProvider>(context);
    final treningiVideos = Provider.of<TreningiVideosProvider>(context);
    final isVideo = Provider.of<IsVideoprovider>(context);
    final trainingBloc = TrainingAPIBloc();
    final scroll = ScrollController();
    final welcomeApi = WelcomeApi(token);
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder<TrainingModel>(
            future: trainingBloc.getTrainingData(token),
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
                          (snapshot.data!.data.webinar.data.isNotEmpty)
                              ? Container(
                                  margin: const EdgeInsets.only(
                                      left: 25, right: 25, bottom: 13),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/event-default.png'),
                                          fit: BoxFit.cover)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 14),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 13,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                    snapshot.data!.data.webinar
                                                        .data.first.date
                                                        .trim()
                                                        .substring(0, 4),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            color: Colors.white,
                                                            fontSize: 20)),
                                                const Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      launchInBrowser(Uri.parse(
                                                          snapshot
                                                              .data!
                                                              .data
                                                              .webinar
                                                              .data
                                                              .first
                                                              .link));
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              64),
                                                      child: Container(
                                                        height: 25,
                                                        color:
                                                            Color(0xff25b049),
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        15),
                                                            child: Text(
                                                              'Зарегистрироваться',
                                                              style: GoogleFonts.montserrat(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 8,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              snapshot.data!.data.webinar.data
                                                      .first.date
                                                      .trim()
                                                      .substring(8, 10) +
                                                  " - " +
                                                  toDateString(snapshot
                                                      .data!
                                                      .data
                                                      .webinar
                                                      .data
                                                      .first
                                                      .date
                                                      .trim()
                                                      .substring(5, 7)),
                                              style: GoogleFonts.montserrat(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                                snapshot.data!.data.webinar.data
                                                    .first.name
                                                    .trim(),
                                                softWrap: true,
                                                overflow: TextOverflow.clip,
                                                style: GoogleFonts.montserrat(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 24)),
                                            SizedBox(
                                              height: 50,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          (snapshot.data!.data.events.events.isNotEmpty)
                              ? CustomCalendar(
                                  dates: snapshot.data!.data.events.events)
                              : const SizedBox(),
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
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: GridView(
                                  controller: scroll,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 30,
                                          childAspectRatio: 3.4),
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
                                        title:
                                            "data.futureEvents.list[0].title",
                                        onTap: () {
                                          treningiPhotos.setUrl(snapshot
                                              .data!
                                              .data
                                              .eventReports
                                              .list[index]
                                              .link);
                                          isVideo.setIsVideo(false);
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
                            children: [
                              Column(
                                children: List.generate(
                                  data.videos.list.length,
                                  (index) {
                                    return CustomClipItem(
                                      backgroundColor: const Color(0xff000004),
                                      buttonColor: const Color(0xffe21a37),
                                      buttonTextColor: const Color(0xffffffff),
                                      titleColor: const Color(0xffffffff),
                                      buttonText: "Смотреть",
                                      title: data.videos.list[index].title,
                                      onTap: () {
                                        treningiVideos.setUrl(
                                            data.videos.list[index].link);
                                        isVideo.setIsVideo(true);
                                        menuBloCProvider.eventSink
                                            .add(MenuActions.trainingVideo);
                                      },
                                    );
                                  },
                                ),
                              ),
                              Column(
                                children: List.generate(
                                  data.eventReports.list.length,
                                  (index) {
                                    return CustomClipItem(
                                      backgroundColor: const Color(0xff000004),
                                      buttonColor: const Color(0xffe21a37),
                                      buttonTextColor: const Color(0xffffffff),
                                      titleColor: const Color(0xffffffff),
                                      buttonText: "Смотреть F",
                                      title:
                                          data.eventReports.list[index].title,
                                      onTap: () {
                                        treningiPhotos.setUrl(
                                            data.eventReports.list[index].link);
                                        isVideo.setIsVideo(false);
                                        menuBloCProvider.eventSink
                                            .add(MenuActions.trainingVideo);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
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
