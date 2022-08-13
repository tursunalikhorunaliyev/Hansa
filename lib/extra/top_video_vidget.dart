import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hansa_app/extra/custom_black_appbar.dart';
import 'package:hansa_app/training_section/custom_treningi_video.dart';
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

  @override
  Widget build(BuildContext context) {
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
