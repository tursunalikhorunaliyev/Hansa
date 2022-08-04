import 'package:flutter/material.dart';
import 'package:hansa_app/blocs/bloc_change_title.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/extra/custom_title.dart';
import 'package:hansa_app/video/bloc_video_api.dart';
import 'package:hansa_app/video/model_video.dart';
import 'package:hansa_app/video_section/custom_video_item.dart';
import 'package:hansa_app/video_section/custom_video_subitem.dart';
import 'package:provider/provider.dart';

class Video extends StatelessWidget {
  const Video({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuEventsBloCProvider = Provider.of<MenuEventsBloC>(context);
    final blocChangeTitleProvider = Provider.of<BlocChangeTitle>(context);
    final blocChangeTitleIndexProvider =
        Provider.of<BlocChangeTitleIndex>(context);
    final token = Provider.of<String>(context);
    final blocVideoApi = BlocVideoApi(token);
    blocVideoApi.eventSink.add(ActionVideo.view);
    return Expanded(
      child: Column(
        children: [
          const CustomTitle(
            imagePath: "assets/video_title.png",
            title: "Видео",
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: StreamBuilder<VideoMainOne>(
                  stream: blocVideoApi.dataStream,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Column(
                        children: List.generate(
                            snapshot.data!.videoListData.list.length, (index) {
                      return Column(
                        children: [
                          CustomVideoSubItem(
                              onTap: () {
                                blocChangeTitleProvider.titleSink.add(snapshot
                                    .data!.videoListData.list[index].title);
                                menuEventsBloCProvider.eventSink
                                    .add(MenuActions.oKompanii);
                                blocChangeTitleIndexProvider.titleSink
                                    .add(index);
                              },
                              title: snapshot
                                  .data!.videoListData.list[index].title),
                          listView(
                              (snapshot.data!.videoListData.list[index].data
                                          .list.length <
                                      5)
                                  ? snapshot.data!.videoListData.list[index]
                                      .data.list.length
                                  : 5,
                              index)
                        ],
                      );
                    }));
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget listView(int itemCount, int indexMain) {
    return SizedBox(
        height: 235,
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
                            )),
                      )),
            ),
          ),
        ));
  }
}
