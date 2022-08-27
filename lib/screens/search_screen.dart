import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/article_model.dart';
import 'package:hansa_app/api_models.dart/search_model.dart';
import 'package:hansa_app/api_services/search_api.dart';
import 'package:hansa_app/blocs/article_bloc.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/classes/send_link.dart';
import 'package:hansa_app/enums/search_action.dart';
import 'package:hansa_app/extra/top_video_vidget.dart';
import 'package:hansa_app/video/model_video.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Map<String, dynamic>? globalData;
  final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    final token = Provider.of<String>(context);
    SearchApi searchApi = SearchApi(token, search.text);

    final articleBLoC = Provider.of<ArticleBLoC>(context);
    final menuProvider = Provider.of<MenuEventsBloC>(context);

    final providerSendLink = Provider.of<SendLink>(context);
    searchApi.eventSink.add(SearchAction.search);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: .90.sw,
                  child: TextField(
                    controller: search,
                    onChanged: (value) {
                      if (value.length > 2) {
                        value = search.text;
                      } else {
                        value = "   ";
                      }
                      setState(() {});
                    },
                    cursorColor: const Color(0xFF272624),
                    cursorHeight: 18,
                    style: const TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      isDense: true,
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF272624),
                        ),
                      ),
                      hintStyle: const TextStyle(fontSize: 12),
                      hintText: "Поиск",
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF272624),
                        ),
                      ),
                      suffixIconConstraints:
                          const BoxConstraints(maxHeight: 20),
                      suffixIcon: InkWell(
                        onTap: () async {
                          if (search.text.length > 2) {
                            log("Search button clicked...");
                            setState(() {});
                          }
                        },
                        child: const Icon(
                          Icons.search,
                          size: 20,
                          color: Color(0xFF272624),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<SearchModel>(
              stream: searchApi.dataStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!.data.data;
                  log("Length of data ${data.length}");
                  return (search.text.length > 2)
                      ? Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(data.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5),
                                  child: InkWell(
                                    onTap: () async {
                                      log(data[index].link);

                                      Navigator.pop(context);

                                      if (data[index].type == 1) {
                                        menuProvider.eventSink
                                            .add(MenuActions.article);
                                        ArticleModel statiModel =
                                            await articleBLoC.getArticle(
                                                token, data[index].link);
                                        articleBLoC.sink.add(statiModel);
                                      } else if (data[index].type == 3) {
                                        providerSendLink
                                            .setLink(data[index].link);
                                        menuProvider.eventSink
                                            .add(MenuActions.chitatStati);
                                      } else if (data[index].type == 4) {
                                        final video = VideoDetails(
                                            title: data[index].title,
                                            pictureLink:
                                                data[index].picturelink,
                                            videoLink: data[index].link);

                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Scaffold(
                                              backgroundColor:
                                                  Colors.transparent,
                                              body: MultiProvider(
                                                providers: [
                                                  Provider(
                                                    create: (context) => index,
                                                  ),
                                                  Provider(
                                                    create: (context) => token,
                                                  ),
                                                ],
                                                child: TopVideoVidget(
                                                  url: video.videoLink,
                                                  title: video.title,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: SizedBox(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: SizedBox(
                                                  height: 65,
                                                  width: 120,
                                                  child: Stack(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        child:
                                                            CachedNetworkImage(
                                                          fit: BoxFit.cover,
                                                          imageUrl: data[index]
                                                              .picturelink,
                                                          height: isTablet
                                                              ? 110
                                                              : 66.66666666666667,
                                                          width: isTablet
                                                              ? 150
                                                              : 101.6666666666667,
                                                        ),
                                                      ),
                                                      (data[index].type == 4)
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 40,
                                                                      top: 21),
                                                              child: Opacity(
                                                                opacity: .5,
                                                                child: Icon(
                                                                  CupertinoIcons
                                                                      .play_circle_fill,
                                                                  size: isTablet
                                                                      ? 45
                                                                      : 25,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 240,
                                                    child: Text(
                                                      data[index].title,
                                                      softWrap: true,
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.montserrat(
                                                          color: const Color(
                                                              0xFF272624),
                                                          fontSize: isTablet
                                                              ? 14
                                                              : 9.666666666666667,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      log(data[index].link);

                                                      if (data[index].type ==
                                                          1) {
                                                        Navigator.pop(context);
                                                        menuProvider.eventSink
                                                            .add(MenuActions
                                                                .article);
                                                        ArticleModel
                                                            statiModel =
                                                            await articleBLoC
                                                                .getArticle(
                                                                    token,
                                                                    data[index]
                                                                        .link);
                                                        articleBLoC.sink
                                                            .add(statiModel);
                                                      } else if (data[index]
                                                              .type ==
                                                          3) {
                                                        Navigator.pop(context);
                                                        providerSendLink
                                                            .setLink(data[index]
                                                                .link);
                                                        menuProvider.eventSink
                                                            .add(MenuActions
                                                                .chitatStati);
                                                      } else if (data[index]
                                                              .type ==
                                                          4) {
                                                        final video = VideoDetails(
                                                            title: data[index]
                                                                .title,
                                                            pictureLink: data[
                                                                    index]
                                                                .picturelink,
                                                            videoLink:
                                                                data[index]
                                                                    .link);

                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return Scaffold(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              body:
                                                                  MultiProvider(
                                                                providers: [
                                                                  Provider(
                                                                    create:
                                                                        (context) =>
                                                                            index,
                                                                  ),
                                                                  Provider(
                                                                    create:
                                                                        (context) =>
                                                                            token,
                                                                  ),
                                                                ],
                                                                child:
                                                                    TopVideoVidget(
                                                                  url: video
                                                                      .videoLink,
                                                                  title: video
                                                                      .title,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: isTablet
                                                            ? 240
                                                            : 175,
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height:
                                                            isTablet ? 22 : 21,
                                                        width:
                                                            isTablet ? 74 : 63,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .transparent),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.5),
                                                            color: const Color(
                                                                0xffe21a37)),
                                                        child: Text(
                                                          "Показать",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 10),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          const Divider(
                                            color: Color(0xFF8c8c8b),
                                            thickness: 1,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        )
                      : const Center();
                } else {
                  return const Center();
                }
              }),
        ],
      ),
    );
  }
}
