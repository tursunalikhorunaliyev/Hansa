import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hansa_app/api_models.dart/treningi_photos_model.dart';
import 'package:hansa_app/api_models.dart/treningi_video_model.dart';
import 'package:hansa_app/api_services/treningi_photos_api.dart';
import 'package:hansa_app/api_services/treningi_video_api.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/blocs/treningi_video_controller.dart';
import 'package:hansa_app/extra/custom_clip_item.dart';
import 'package:hansa_app/extra/custom_tablet_stati_item.dart';
import 'package:hansa_app/extra/custom_title.dart';
import 'package:hansa_app/providers/is_video_provider.dart';
import 'package:hansa_app/providers/treningi_photos_provider.dart';
import 'package:hansa_app/providers/treningi_videos_provider.dart';
import 'package:hansa_app/training_video_section/custom_tablet_photos.dart';
import 'package:hansa_app/training_video_section/custom_treningi_photos.dart';
import 'package:hansa_app/training_video_section/custom_treningi_video_play.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class TreningiVideo extends StatefulWidget {
  const TreningiVideo({Key? key}) : super(key: key);

  @override
  State<TreningiVideo> createState() => _TreningiVideoState();
}

class _TreningiVideoState extends State<TreningiVideo> {
  final scroll = ScrollController();

  ChewieController chewieController = ChewieController(
    aspectRatio: 16 / 9,
    videoPlayerController: VideoPlayerController.network(
      '',
    ),
  );
  @override
  void dispose() {
    chewieController.dispose();
    chewieController.videoPlayerController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final videoControll = Provider.of<TreningiVideoControll>(context);
    final isTablet = Provider.of<bool>(context);
    final token = Provider.of<String>(context);
    final treningiPhotos = Provider.of<TreningiPhotosProvider>(context);
    final treningiVideos = Provider.of<TreningiVideosProvider>(context);
    final isVideo = Provider.of<IsVideoprovider>(context);
    final menuBloCProvider = Provider.of<MenuEventsBloC>(context);
    return Expanded(
      child: SingleChildScrollView(
        controller: scroll,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            StickyHeader(
              header: const CustomTitle(
                imagePath: "assets/treningi_title.png",
                title: "Тренинги",
              ),
              content: Column(
                children: [
                  Row(),
                  !isVideo.getIsVideo
                      ? isTablet
                          ? const TabletPhotosItem()
                          : const CustomTreningiPhotos()
                      : SizedBox(
                          height: 350,
                          child: CustomTreningiVideoPlay(
                            chewieController: chewieController,
                          ),
                        ),
                ],
              ),
            ),
            !isVideo.getIsVideo
                ? StickyHeader(
                    header: const CustomTitle(
                      imagePath: "assets/kak_title.png",
                      title: "Похожие мероприятия",
                    ),
                    content: FutureBuilder<TreningiPhotosModel>(
                      future: TreningiPhotosApi.getdata(
                          treningiPhotos.getUrl, token),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return isTablet
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 11.w),
                                      child: GridView(
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 10 / 3),
                                        children: List.generate(
                                          snapshot
                                              .data!.data.similar.list.length,
                                          (index) => CustomStatiTabletItem(
                                              onTap: () {
                                                treningiPhotos.setUrl(snapshot
                                                    .data!
                                                    .data
                                                    .similar
                                                    .list[index]
                                                    .link);
                                                isVideo.setIsVideo(false);
                                                scroll.animateTo(
                                                  0,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease,
                                                );
                                                setState(() {});
                                              },
                                              backgroundColor:
                                                  const Color(0xff000004),
                                              buttonColor:
                                                  const Color(0xffe21a37),
                                              buttonTextColor:
                                                  const Color(0xffffffff),
                                              titleColor:
                                                  const Color(0xffffffff),
                                              buttonText: "Смотреть",
                                              title: snapshot.data!.data.similar
                                                  .list[index].title),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: List.generate(
                                    snapshot.data!.data.similar.list.length,
                                    (index) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomClipItem(
                                            onTap: () {
                                              treningiPhotos.setUrl(snapshot
                                                  .data!
                                                  .data
                                                  .similar
                                                  .list[index]
                                                  .link);
                                              isVideo.setIsVideo(false);
                                              scroll.animateTo(
                                                0,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                curve: Curves.ease,
                                              );
                                              setState(() {});
                                            },
                                            backgroundColor:
                                                const Color(0xff000004),
                                            buttonColor:
                                                const Color(0xffe21a37),
                                            buttonTextColor:
                                                const Color(0xffffffff),
                                            titleColor: const Color(0xffffffff),
                                            buttonText: "Смотреть",
                                            title: snapshot.data!.data.similar
                                                .list[index].title),
                                      ],
                                    ),
                                  ),
                                );
                        } else {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                          );
                        }
                      },
                    ),
                  )
                : StickyHeader(
                    header: const CustomTitle(
                      imagePath: "assets/kak_title.png",
                      title: "Похожие мероприятия",
                    ),
                    content: FutureBuilder<TreningiVideoModel>(
                      future: TreningiVideoApi.getTreningiVideo(
                          treningiVideos.getUrl, token),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return isTablet
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 11.w),
                                      child: GridView(
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 10 / 3),
                                        children: List.generate(
                                          snapshot
                                              .data!.data.similar.data.length,
                                          (index) => CustomStatiTabletItem(
                                            onTap: () {
                                              videoControll.sink.add(true);
                                              treningiVideos.setUrl(
                                                snapshot.data!.data.similar
                                                    .data[index].link,
                                              );
                                              isVideo.setIsVideo(true);
                                              scroll.animateTo(
                                                0,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                curve: Curves.ease,
                                              );
                                              videoControll.sink.add(false);
                                              setState(() {});
                                            },
                                            backgroundColor:
                                                const Color(0xff000004),
                                            buttonColor:
                                                const Color(0xffe21a37),
                                            buttonTextColor:
                                                const Color(0xffffffff),
                                            titleColor: const Color(0xffffffff),
                                            buttonText: "Смотреть",
                                            title: snapshot.data!.data.similar
                                                .data[index].title,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: List.generate(
                                    snapshot.data!.data.similar.data.length,
                                    (index) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomClipItem(
                                          onTap: () {
                                            videoControll.sink.add(true);
                                            treningiVideos.setUrl(
                                              snapshot.data!.data.similar
                                                  .data[index].link,
                                            );
                                            isVideo.setIsVideo(true);
                                            videoControll.sink.add(false);

                                            scroll.animateTo(
                                              0,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.ease,
                                            );
                                            menuBloCProvider.eventSink
                                                .add(MenuActions.trainingVideo);
                                            setState(() {});
                                          },
                                          backgroundColor:
                                              const Color(0xff000004),
                                          buttonColor: const Color(0xffe21a37),
                                          buttonTextColor:
                                              const Color(0xffffffff),
                                          titleColor: const Color(0xffffffff),
                                          buttonText: "Смотреть",
                                          title: snapshot.data!.data.similar
                                              .data[index].title,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        } else {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                          );
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
