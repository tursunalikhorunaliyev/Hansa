import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/blocs/bloc_change_title.dart';
import 'package:hansa_app/blocs/bloc_play_video.dart';
import 'package:hansa_app/blocs/download_progress_bloc.dart';
import 'package:hansa_app/extra/custom_okompanii_item.dart';
import 'package:hansa_app/extra/custom_title.dart';
import 'package:hansa_app/providers/providers_for_video_title/video_index_provider.dart';
import 'package:hansa_app/providers/providers_for_video_title/video_title_provider.dart';
import 'package:hansa_app/video/bloc_video_api.dart';
import 'package:hansa_app/video/model_video.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

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
    setState(() {
      downloading = true;
    });
    String savePath = await getFilePath(fileName);
    Dio dio = Dio();
    dio.download(
      url,
      savePath,
      onReceiveProgress: (recieved, total) {
        print(((recieved / total) * 100).toStringAsFixed(0));

        progress = double.parse(((recieved / total) * 100).toStringAsFixed(0));
        blocDownload.streamSink.add(progress);
        if (progress == 100) {
          setState(() {
            isDownloaded = true;
          });
        } else if (progress < 100) {}
      },
      deleteOnError: true,
    ).then((value) {
      setState(() {
        if (progress == 100) {
          isDownloaded = true;
        }
        downloading = false;
      });
    });
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = "";
    String dir = "/storage/emulated/0/Download/";
    path = "$dir/$uniqueFileName.mp4";
    return path;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final playProvider = Provider.of<BlocPlayVideo>(context);
    final blocChangeTitleIndexProvider =
        Provider.of<BlocChangeTitleIndex>(context);
    final token = Provider.of<String>(context);
    final blocVideoApi = BlocVideoApi(token);
    blocVideoApi.eventSink.add(ActionVideo.view);
    return Expanded(
      child: Column(
        children: [
          Consumer<VideoTitleProvider>(builder: (context, value, child) {
            return CustomTitle(
              imagePath: "assets/Lab.png",
              title: value.getTitle,
            );
          }),
          Expanded(
            child:
                Consumer<VideoIndexProvider>(builder: (context, value, child) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: StreamBuilder<VideoMainOne>(
                    stream: blocVideoApi.dataStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: List.generate(
                            snapshot.data!.videoListData.list[value.getIndex]
                                .data.list.length,
                            (index) => CustomOKompaniiItem(
                              imageUrl: snapshot
                                  .data!
                                  .videoListData
                                  .list[value.getIndex]
                                  .data
                                  .list[index]
                                  .pictureLink,
                              title: snapshot.data!.videoListData
                                  .list[value.getIndex].data.list[index].title,
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
                                            builder: (context, snapshotDouble) {
                                              return SizedBox(
                                                height: 250,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: CachedNetworkImage(
                                                        imageUrl: snapshot
                                                            .data!
                                                            .videoListData
                                                            .list[
                                                                value.getIndex]
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
                                                          const EdgeInsets.all(
                                                              0),
                                                      barRadius:
                                                          Radius.circular(5),
                                                      lineHeight: 15,
                                                      //width: 325,
                                                      percent:
                                                          snapshotDouble.data! /
                                                              100,
                                                      center: Text(
                                                        "${snapshotDouble.data}%",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 10,
                                                          color: Colors.black,
                                                        ),
                                                      ),

                                                      backgroundColor:
                                                          Colors.transparent,
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
                                                            .list[
                                                                value.getIndex]
                                                            .data
                                                            .list[index]
                                                            .title
                                                            .toString(),
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12),
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
                                playProvider.sink.add([
                                  true,
                                  video.videoLink,
                                  video.title,
                                  false
                                ]);
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
