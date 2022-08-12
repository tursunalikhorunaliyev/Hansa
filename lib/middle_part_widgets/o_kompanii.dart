import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_services/welcome_api.dart';
import 'package:hansa_app/blocs/bloc_play_video.dart';
import 'package:hansa_app/blocs/download_progress_bloc.dart';
import 'package:hansa_app/extra/custom_okompanii_item.dart';
import 'package:hansa_app/extra/custom_title.dart';
import 'package:hansa_app/providers/providers_for_video_title/video_index_provider.dart';
import 'package:hansa_app/providers/providers_for_video_title/video_title_provider.dart';
import 'package:hansa_app/training_section/custom_treningi_video.dart';
import 'package:hansa_app/video/bloc_video_api.dart';
import 'package:hansa_app/video/model_video.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class OKompanii extends StatefulWidget {
  const OKompanii({Key? key}) : super(key: key);

  @override
  State<OKompanii> createState() => _OKompaniiState();
}

class _OKompaniiState extends State<OKompanii> {
  final blocDownload = DownloadProgressFileBloc();

  bool downloading = false;
  double progress = 0;
  bool isDownloaded = false;

  Future<void> downloadFile(String url, String fileName) async {
    progress = 0;

    String savePath = await getFilePath(fileName);
    Dio dio = Dio();
    dio.download(
      url,
      savePath,
      onReceiveProgress: (recieved, total) {
        print(((recieved / total) * 100).toStringAsFixed(0));
        progress = double.parse(((recieved / total) * 100).toStringAsFixed(0));
        blocDownload.streamSink.add(progress);
      },
      deleteOnError: true,
    );
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = "";
    String dir = "";
    if (Platform.isIOS) {
      Directory directory = await getApplicationSupportDirectory();
      dir = directory.path;
    } else if (Platform.isAndroid) {
      dir = "/storage/emulated/0/Download/";
    }
    path = "$dir/$uniqueFileName.mp4";
    return path;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);

    final token = Provider.of<String>(context);

    final welcomeApi = WelcomeApi(token);
    welcomeApi.eventSink.add(WelcomeApiAction.fetch);
    final scroll = ScrollController();
    final blocVideoApi = BlocVideoApi(token);
    blocVideoApi.eventSink.add(ActionVideo.view);
    return Expanded(
      child: Consumer<VideoIndexProvider>(builder: (context, value, child) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: StreamBuilder<VideoMainOne>(
              stream: blocVideoApi.dataStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Consumer<VideoTitleProvider>(
                          builder: (context, value, child) {
                        return CustomTitle(
                          imagePath: "assets/Lab.png",
                          title: value.getTitle,
                        );
                      }),
                      isTablet
                          ? NotificationListener(
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
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 30,
                                          childAspectRatio: 10 / 8.2),
                                  children: List.generate(
                                      snapshot.data!.videoListData.list.length,
                                      (index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: CustomOKompaniiItem(
                                        imageUrl: snapshot
                                            .data!
                                            .videoListData
                                            .list[value.getIndex]
                                            .data
                                            .list[index]
                                            .pictureLink,
                                        title: snapshot
                                            .data!
                                            .videoListData
                                            .list[value.getIndex]
                                            .data
                                            .list[index]
                                            .title,
                                        onDownload: () {
                                          downloadFile(
                                              snapshot
                                                  .data!
                                                  .videoListData
                                                  .list[value.getIndex]
                                                  .data
                                                  .list[index]
                                                  .videoLink,
                                              snapshot
                                                  .data!
                                                  .videoListData
                                                  .list[value.getIndex]
                                                  .data
                                                  .list[index]
                                                  .title);

                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  actionsPadding:
                                                      EdgeInsets.only(
                                                          bottom: 20,
                                                          right: 20),
                                                  alignment: Alignment.center,
                                                  content: StreamBuilder<
                                                          double>(
                                                      stream:
                                                          blocDownload.stream,
                                                      initialData: 0,
                                                      builder: (context,
                                                          snapshotDouble) {
                                                        return SizedBox(
                                                          height: 250,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: snapshot
                                                                      .data!
                                                                      .videoListData
                                                                      .list[value
                                                                          .getIndex]
                                                                      .data
                                                                      .list[
                                                                          index]
                                                                      .pictureLink,
                                                                  height: 165,
                                                                  width: 325,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              LinearPercentIndicator(
                                                                alignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(0),
                                                                barRadius: Radius
                                                                    .circular(
                                                                        5),
                                                                lineHeight: 15,
                                                                //width: 325,
                                                                percent:
                                                                    snapshotDouble
                                                                            .data! /
                                                                        100,
                                                                center: Text(
                                                                  "${snapshotDouble.data}%",
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),

                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                progressColor:
                                                                    Colors
                                                                        .green,
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .videoListData
                                                                      .list[value
                                                                          .getIndex]
                                                                      .data
                                                                      .list[
                                                                          index]
                                                                      .title
                                                                      .toString(),
                                                                  style: GoogleFonts.montserrat(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                );
                                              });
                                        },
                                        onTap: () {
                                          final VideoDetails video = snapshot
                                              .data!
                                              .videoListData
                                              .list[value.getIndex]
                                              .data
                                              .list[index];
                                        },
                                      ),
                                    );
                                  }),
                                ),
                              ))
                          : Column(
                              children: List.generate(
                                snapshot.data!.videoListData
                                    .list[value.getIndex].data.list.length,
                                (index) => CustomOKompaniiItem(
                                  imageUrl: snapshot
                                      .data!
                                      .videoListData
                                      .list[value.getIndex]
                                      .data
                                      .list[index]
                                      .pictureLink,
                                  title: snapshot
                                      .data!
                                      .videoListData
                                      .list[value.getIndex]
                                      .data
                                      .list[index]
                                      .title,
                                  onDownload: () {
                                    downloadFile(
                                        snapshot
                                            .data!
                                            .videoListData
                                            .list[value.getIndex]
                                            .data
                                            .list[index]
                                            .videoLink,
                                        snapshot
                                            .data!
                                            .videoListData
                                            .list[value.getIndex]
                                            .data
                                            .list[index]
                                            .title);

                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            actionsPadding: EdgeInsets.only(
                                                bottom: 20, right: 20),
                                            alignment: Alignment.center,
                                            content: StreamBuilder<double>(
                                                stream: blocDownload.stream,
                                                initialData: 0,
                                                builder:
                                                    (context, snapshotDouble) {
                                                  return SizedBox(
                                                    height: 250,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: snapshot
                                                                .data!
                                                                .videoListData
                                                                .list[value
                                                                    .getIndex]
                                                                .data
                                                                .list[index]
                                                                .pictureLink,
                                                            height: 165,
                                                            width: 325,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        LinearPercentIndicator(
                                                          alignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          barRadius:
                                                              Radius.circular(
                                                                  5),
                                                          lineHeight: 15,
                                                          //width: 325,
                                                          percent:
                                                              snapshotDouble
                                                                      .data! /
                                                                  100,
                                                          center: Text(
                                                            "${snapshotDouble.data}%",
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),

                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          progressColor:
                                                              Colors.green,
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            snapshot
                                                                .data!
                                                                .videoListData
                                                                .list[value
                                                                    .getIndex]
                                                                .data
                                                                .list[index]
                                                                .title
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          );
                                        });
                                  },
                                  onTap: () {
                                    final VideoDetails video = snapshot
                                        .data!
                                        .videoListData
                                        .list[value.getIndex]
                                        .data
                                        .list[index];
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        ChewieController chewieController =
                                            ChewieController(
                                          aspectRatio: 16 / 9,
                                          autoPlay: true,
                                          allowedScreenSleep: false,
                                          autoInitialize: true,
                                          deviceOrientationsOnEnterFullScreen: [
                                            DeviceOrientation.landscapeLeft,
                                            DeviceOrientation.landscapeRight
                                          ],
                                          deviceOrientationsAfterFullScreen: [
                                            DeviceOrientation.portraitDown,
                                            DeviceOrientation.portraitUp
                                          ],
                                          allowMuting: false,
                                          videoPlayerController:
                                              VideoPlayerController.network(
                                                  video.videoLink),
                                          cupertinoProgressColors:
                                              ChewieProgressColors(
                                            backgroundColor:
                                                const Color(0xff090909),
                                            bufferedColor:
                                                const Color(0xff090909),
                                            playedColor:
                                                const Color(0xffff0000),
                                            handleColor:
                                                const Color(0xffff0000),
                                          ),
                                          materialProgressColors:
                                              ChewieProgressColors(
                                            backgroundColor:
                                                const Color(0xff090909),
                                            bufferedColor:
                                                const Color(0xff090909),
                                            playedColor:
                                                const Color(0xffff0000),
                                            handleColor:
                                                const Color(0xffff0000),
                                          ),
                                        );
                                        return Scaffold(
                                          backgroundColor: Colors.transparent,
                                          body: InkWell(
                                            onTap: () {
                                              chewieController
                                                  .videoPlayerController
                                                ..seekTo(
                                                    const Duration(seconds: 0))
                                                ..pause();
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const SizedBox(
                                                        height: 13,
                                                      ),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: SizedBox(
                                                          width: 325,
                                                          height: 185,
                                                          child: Center(
                                                            child: Chewie(
                                                              controller:
                                                                  chewieController,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 13),
                                                        child:
                                                            CustomTreningiVideo(
                                                          title: video.title,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                    ],
                  );
                } else {
                  return Center(
                      child: Padding(
                    padding: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.height / 2) - 135),
                    child: Lottie.asset(
                      'assets/pre.json',
                      height: 70,
                      width: 70,
                    ),
                  ));
                }
              }),
        );
      }),
    );
  }
}
