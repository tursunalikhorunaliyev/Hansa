import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/blocs/bloc_play_video.dart';
import 'package:hansa_app/blocs/bloc_video_controll.dart';
import 'package:hansa_app/extra/black_custom_title.dart';
import 'package:hansa_app/extra/custom_black_appbar.dart';
import 'package:hansa_app/training_section/custom_treningi_video.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class TopVideoWidget extends StatefulWidget {
  final String url;
  final String title;
  
  const TopVideoWidget(
      {Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  State<TopVideoWidget> createState() => _TopVideoWidgetState();
}

class _TopVideoWidgetState extends State<TopVideoWidget> {
  late ChewieController? chewieController;
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

  @override
  Widget build(BuildContext context) {
    final playProvider = Provider.of<BlocPlayVideo>(context);
    final videoControlProvider = Provider.of<BlocVideoControll>(context);
    videoControlProvider.stream.listen((event) {
      if (event == false) {
        chewieController!.videoPlayerController
          ..seekTo(const Duration(seconds: 0))
          ..pause();
        setState(() {});
      }
    });
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
              playProvider.sink.add([false, "", ""]);
              videoControlProvider.sink.add(false);
            },
          ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 32),
                        child: PhysicalModel(
                          shadowColor: Colors.grey.withOpacity(.5),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(64),
                          elevation: 5,
                          child: GestureDetector(
                            onTap: () {},
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
                      width: 325,
                      height: 185,
                      child: Center(
                        child: Chewie(
                          controller: chewieController!,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 13),
                    child: CustomTreningiVideo(
                      title: widget.title,
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
}
