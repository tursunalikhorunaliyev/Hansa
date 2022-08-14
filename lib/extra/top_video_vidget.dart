import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hansa_app/blocs/download_progress_bloc.dart';
import 'package:hansa_app/extra/custom_black_appbar.dart';
import 'package:hansa_app/providers/providers_for_video_title/video_index_provider.dart';
import 'package:hansa_app/training_section/custom_treningi_video.dart';
import 'package:hansa_app/video/bloc_video_api.dart';
import 'package:hansa_app/video/model_video.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class TopVideoVidget extends StatefulWidget {
  final String url;
  final String title;

  const TopVideoVidget({Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  State<TopVideoVidget> createState() => _TopVideoVidgetState();
}

class _TopVideoVidgetState extends State<TopVideoVidget> {
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

  final blocVideoApi = BlocVideoApi();

  final blocDownload = DownloadProgressFileBloc();

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

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<String>(context);
    final providerIndex = Provider.of<int>(context);

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
              chewieController.videoPlayerController
                ..seekTo(const Duration(seconds: 0))
                ..pause();
              setState(() {});
              Navigator.pop(context);
            },
          ),
          Column(
            children: [
              const CustomBlackAppBar(),
              Column(
                children: [
                  const SizedBox(
                    height: 80,
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
                  Consumer<VideoIndexProvider>(
                    builder: (context, value, child) {
                      return FutureBuilder<VideoMainOne>(
                        future: blocVideoApi.getData(token: token),
                        builder: (context, snapshot) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 13),
                            child: CustomTreningiVideo(
                              onTap: () {
                                downloadFile(
                                    snapshot
                                        .data!
                                        .videoListData
                                        .list[value.getIndex]
                                        .data
                                        .list[providerIndex]
                                        .videoLink,
                                    snapshot
                                        .data!
                                        .videoListData
                                        .list[value.getIndex]
                                        .data
                                        .list[providerIndex]
                                        .title);
                              },
                              title: widget.title,
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
