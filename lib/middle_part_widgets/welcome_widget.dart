import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/article_model.dart';
import 'package:hansa_app/api_models.dart/welcome_model.dart';
import 'package:hansa_app/api_services/welcome_api.dart';
import 'package:hansa_app/blocs/article_bloc.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/extra/event_cards.dart';
import 'package:hansa_app/extra/my_behavior%20.dart';
import 'package:hansa_app/stacked_stack.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  void initState() {
   
   super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final scroll = ScrollController();
    final isTablet = Provider.of<bool>(context);
    final token = Provider.of<String>(context);
    final welcomeApi = WelcomeApi(token);
    welcomeApi.eventSink.add(WelcomeApiAction.fetch);
    final articleBLoC = Provider.of<ArticleBLoC>(context);
    final menuProvider = Provider.of<MenuEventsBloC>(context);

    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Container(
            alignment: Alignment.center,
            color: const Color(0xffeaeaea),
            height: 40,
            width: double.infinity,
            child: Text(
              'Добро пожаловать',
              style: GoogleFonts.montserrat(
                  fontSize: isTablet ? 30 : 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff272624)),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: StreamBuilder<List<WelcomeModelData>>(
                stream: welcomeApi.dataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.requireData;
                    return isTablet
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: ScrollConfiguration(
                              behavior: MyBehavior(),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: SizedBox(
                                          height: 450,
                                          child: Chewie(controller: ChewieController(videoPlayerController: VideoPlayerController.network("https://hansa-lab.ru/storage/upload/videos/1d-otmvmwUva.mp4"), aspectRatio: 13.6/7.2, autoPlay: true)
                                            ),
                                        ),
                                      ),
                                    ),
                                      
                                    GridView(
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 10,
                                           mainAxisExtent: 375,
                                              ),
                                      children: List.generate(
                                        data.length,
                                        (index) => StackedStack(  isFavouriteURL: snapshot
                                              .data![index].favoriteLink,
                                          onTap: () async {
                                            menuProvider.eventSink
                                                .add(MenuActions.article);
                                            ArticleModel statiModel =
                                                await articleBLoC.getArticle(
                                                    token,
                                                    snapshot.data![index].link);
                                            articleBLoC.sink.add(statiModel);
                                          },
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
                                          isFavourite: data[index].isFavorite,)
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          welcomeApi.eventSink
                                              .add(WelcomeApiAction.fetch);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: isTablet ? 100 : 120,
                                          height: isTablet ? 28 : 30,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(13)),
                                          child: Text(
                                            "показать ещё",
                                            style: GoogleFonts.montserrat(
                                                fontSize: isTablet ? 12 : 10,
                                                color: const Color(0xffffffff),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SingleChildScrollView(
                            controller: scroll,
                            child: Column(
                              children: [
                                Column(
                                  children: List.generate(data.length, (index) {
                                    return EventCards(
                                      isFavouriteURL:
                                          snapshot.data![index].favoriteLink,
                                      onTap: () async {
                                        menuProvider.eventSink
                                            .add(MenuActions.article);
                                        ArticleModel statiModel =
                                            await articleBLoC.getArticle(token,
                                                snapshot.data![index].link);
                                        articleBLoC.sink.add(statiModel);
                                      },
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
                                    );
                                  }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      welcomeApi.eventSink
                                          .add(WelcomeApiAction.fetch);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: isTablet ? 100 : 120,
                                      height: isTablet ? 28 : 30,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 4,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      child: Text(
                                        "показать ещё",
                                        style: GoogleFonts.montserrat(
                                            fontSize: isTablet ? 12 : 10,
                                            color: const Color(0xffffffff),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                  } else {
                    welcomeApi.eventSink.add(WelcomeApiAction.fetch);
                    return Center(
                        child: Lottie.asset(
                      'assets/pre.json',
                      height: 70,
                      width: 70,
                    ));
                  }
                }),
          ),
        ],
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
