import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/blocs/bloc_detect_tap.dart';
import 'package:hansa_app/blocs/download_progress_bloc.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/extra/black_custom_title.dart';
import 'package:hansa_app/extra/custom_black_appbar.dart';
import 'package:hansa_app/providers/providers_for_video_title/video_index_provider.dart';
import 'package:hansa_app/providers/providers_for_video_title/video_title_provider.dart';
import 'package:hansa_app/training_section/custom_treningi_video.dart';
import 'package:hansa_app/video/bloc_video_api.dart';
import 'package:hansa_app/video/model_video.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class TopVideoWidget extends StatefulWidget {
  final String url;
  final String title;
  final int selectedIndex;
  final String selectedTitle;

  const TopVideoWidget(
      {Key? key,
      required this.url,
      required this.title,
      required this.selectedIndex,
      required this.selectedTitle})
      : super(key: key);

  @override
  State<TopVideoWidget> createState() => _TopVideoWidgetState();
}

class _TopVideoWidgetState extends State<TopVideoWidget> {
  ChewieController chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.network(''));
  initVideo() {
    chewieController = ChewieController(
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
      videoPlayerController: VideoPlayerController.network(widget.url),
      cupertinoProgressColors: ChewieProgressColors(
        backgroundColor: const Color(0xff090909),
        bufferedColor: const Color(0xff090909),
        playedColor: const Color(0xffff0000),
        handleColor: const Color(0xffff0000),
      ),
      materialProgressColors: ChewieProgressColors(
        backgroundColor: const Color(0xff090909),
        bufferedColor: const Color(0xff090909),
        playedColor: const Color(0xffff0000),
        handleColor: const Color(0xffff0000),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initVideo();
  }

  final blocDetectTap = BlocDetectTap();
  final blocVideoApi = BlocVideoApi();

  bool downloading = false;
  double progress = 0;
  bool isDownloaded = false;

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

  Future<void> downloadFile(String url, String fileName,
      DownloadProgressFileBloc downloadProgressFileBloc) async {
    progress = 0;

    String savePath = await getFilePath(fileName);
    Dio dio = Dio();
    dio.download(
      url,
      savePath,
      onReceiveProgress: (recieved, total) {
        print(((recieved / total) * 100).toStringAsFixed(0));
        progress = double.parse(((recieved / total) * 100).toStringAsFixed(0));
        downloadProgressFileBloc.streamSink.add(progress);
      },
      deleteOnError: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final menuEventsBloCProvider = Provider.of<MenuEventsBloC>(context);
    final title = Provider.of<VideoTitleProvider>(context);
    final index = Provider.of<VideoIndexProvider>(context);
    final providerBlocProgress = Provider.of<DownloadProgressFileBloc>(context);
    final token = Provider.of<String>(context);

    return SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(.9),
                  Colors.black.withOpacity(.9),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              reset();
              Navigator.pop(context);
            },
          ),
          Column(
            children: [
              Column(
                children: [
                  const CustomBlackAppBar(),
                  Row(
                    children: const [
                      BlackCustomTitle(
                        imagePath: "assets/video_title.png",
                        title: "Видео",
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 355,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            PhysicalModel(
                              shadowColor: Colors.grey.withOpacity(.5),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(64),
                              elevation: 5,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  reset();
                                  menuEventsBloCProvider.eventSink
                                      .add(MenuActions.oKompanii);
                                  title.changeTitle(widget.selectedTitle);
                                  index.changeIndex(widget.selectedIndex);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(64),
                                  child: Container(
                                    padding: const EdgeInsets.all(7),
                                    constraints: const BoxConstraints(
                                      minWidth: 90,
                                    ),
                                    color: const Color(0xffff163e),
                                    child: Center(
                                      child: Text(
                                        "Открыть раздел",
                                        style: GoogleFonts.montserrat(
                                          color: const Color(0xffffffff),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 13,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      width: 355,
                      height: 200,
                      child: Center(
                        child: Chewie(
                          controller: chewieController,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 13),
                    child: Consumer<VideoIndexProvider>(
                      builder: (context, value, child) {
                        return FutureBuilder<VideoMainOne>(
                          future: blocVideoApi.getData(token: token),
                          builder: (context, snapshot) {
                            return Provider(
                              create: (context) => blocDetectTap,
                              child: StreamBuilder<double>(
                                  stream: providerBlocProgress.stream,
                                  builder: (context, snapshotProgress) {
                                    return CustomTreningiVideo(
                                      onTap: () {
                                        blocDetectTap.dataSink.add(true);

                                        if (snapshotProgress.data == null ||
                                            snapshotProgress.data == 0) {
                                          downloadFile(
                                            snapshot
                                                .data!
                                                .videoListData
                                                .list[value.getIndex]
                                                .data
                                                .list[widget.selectedIndex]
                                                .videoLink,
                                            snapshot
                                                .data!
                                                .videoListData
                                                .list[value.getIndex]
                                                .data
                                                .list[widget.selectedIndex]
                                                .title,
                                            providerBlocProgress,
                                          );
                                        } else {
                                          log("asdffffffffffff=----------------------------------------");
                                        }
                                      },
                                      title: widget.title,
                                    );
                                  }),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  reset() {
    chewieController.videoPlayerController
      ..seekTo(const Duration(seconds: 0))
      ..pause();
    setState(() {});
  }
}
