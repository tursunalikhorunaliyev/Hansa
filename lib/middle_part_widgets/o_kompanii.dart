import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hansa_app/blocs/bloc_change_title.dart';
import 'package:hansa_app/blocs/bloc_play_video.dart';
import 'package:hansa_app/extra/custom_okompanii_item.dart';
import 'package:hansa_app/extra/custom_title.dart';
import 'package:hansa_app/video/bloc_video_api.dart';
import 'package:hansa_app/video/model_video.dart';
import 'package:provider/provider.dart';

class OKompanii extends StatelessWidget {
  const OKompanii({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int i = 0;
    final playProvider = Provider.of<BlocPlayVideo>(context);
    final blocChangeTitleProvider = Provider.of<BlocChangeTitle>(context);
    final blocChangeTitleIndexProvider =
        Provider.of<BlocChangeTitleIndex>(context);
    final token = Provider.of<String>(context);
    final blocVideoApi = BlocVideoApi(token);
    blocVideoApi.eventSink.add(ActionVideo.view);
    return Expanded(
      child: Column(
        children: [
          StreamBuilder<dynamic>(
              stream: blocChangeTitleProvider.titleStream,
              initialData: "",
              builder: (context, snapshot) {
                return CustomTitle(
                    imagePath: "assets/Lab.png", title: snapshot.data!);
              }),
          Expanded(
            child: StreamBuilder<int>(
                stream: blocChangeTitleIndexProvider.titleStream,
                builder: (context, i) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: StreamBuilder<VideoMainOne>(
                        stream: blocVideoApi.dataStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && i.hasData) {
                            return Column(
                              children: List.generate(
                                snapshot.data!.videoListData.list[i.data!].data
                                    .list.length,
                                (index) => CustomOKompaniiItem(
                                  imageUrl: snapshot
                                      .data!
                                      .videoListData
                                      .list[i.data!]
                                      .data
                                      .list[index]
                                      .pictureLink,
                                  title: snapshot.data!.videoListData
                                      .list[i.data!].data.list[index].title,
                                  onDownload: () {},
                                  onTap: () {
                                    final VideoDetails video = snapshot
                                        .data!
                                        .videoListData
                                        .list[i.data!]
                                        .data
                                        .list[index];
                                    playProvider.sink.add(
                                        [true, video.videoLink, video.title]);
                                  },
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                                child: SpinKitWanderingCubes(
                              color: Colors.red,
                            ));
                          }
                        }),
                  );
                }),
          )
        ],
      ),
    );
  }
}
