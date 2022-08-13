import 'package:flutter/material.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/extra/custom_title.dart';
import 'package:hansa_app/providers/providers_for_video_title/video_index_provider.dart';
import 'package:hansa_app/providers/providers_for_video_title/video_title_provider.dart';
import 'package:hansa_app/video/bloc_video_api.dart';
import 'package:hansa_app/video/model_video.dart';
import 'package:hansa_app/video_section/custom_video_item.dart';
import 'package:hansa_app/video_section/custom_video_subitem.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Video extends StatelessWidget {
  const Video({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuEventsBloCProvider = Provider.of<MenuEventsBloC>(context);
    final token = Provider.of<String>(context);
    final blocVideoApi = BlocVideoApi();
    final isTablet = Provider.of<bool>(context);
    final title = Provider.of<VideoTitleProvider>(context);
    final index = Provider.of<VideoIndexProvider>(context);
    return Expanded(
      child: Expanded(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: FutureBuilder<VideoMainOne>(
              future: blocVideoApi.getData(token: token),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
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
                return Column(
                  children: [
                    const CustomTitle(
                      imagePath: "assets/video_title.png",
                      title: "Видео",
                    ),
                    Column(
                        children: List.generate(
                            snapshot.data!.videoListData.list.length, (i) {
                      return Column(
                        children: [
                          CustomVideoSubItem(
                              onTap: () {
                                title.changeTitle(
                                    snapshot.data!.videoListData.list[i].title);
                                menuEventsBloCProvider.eventSink
                                    .add(MenuActions.oKompanii);
                                index.changeIndex(i);
                              },
                              title:
                                  snapshot.data!.videoListData.list[i].title),
                          listView(
                            (snapshot.data!.videoListData.list[i].data.list
                                        .length <
                                    5)
                                ? snapshot.data!.videoListData.list[i].data.list
                                    .length
                                : 5,
                            i,
                            isTablet,
                          )
                        ],
                      );
                    })),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget listView(int itemCount, int indexMain, bool isTablet) {
    return SizedBox(
      height: isTablet ? 360 : 220,
      child: Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              itemCount,
              (index) => Padding(
                padding: EdgeInsets.only(left: (index == 0) ? 30 : 0),
                child: GestureDetector(
                  onTap: () {},
                  child: CustomVideoListItem(
                    index: index,
                    indexMain: indexMain,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
