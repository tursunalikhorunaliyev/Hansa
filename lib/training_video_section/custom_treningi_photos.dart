import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/treningi_photos_model.dart';
import 'package:hansa_app/api_services/treningi_photos_api.dart';
import 'package:hansa_app/blocs/bloc_detect_tap.dart';
import 'package:hansa_app/blocs/download_progress_bloc.dart';
import 'package:hansa_app/classes/send__index_trening_photo.dart';
import 'package:hansa_app/providers/treningi_photos_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class CustomTreningiPhotos extends StatefulWidget {
  const CustomTreningiPhotos({Key? key}) : super(key: key);

  @override
  State<CustomTreningiPhotos> createState() => _CustomTreningiPhotosState();
}

class _CustomTreningiPhotosState extends State<CustomTreningiPhotos> {
  bool downloading = false;

  double progress = 0;

  bool isDownloaded = false;

  Future<String> getFilePath(uniqueFileName, fileName) async {
    String path = "";
    String dir = "";
    if (Platform.isIOS) {
      Directory directory = await getApplicationSupportDirectory();
      dir = directory.path;
    } else if (Platform.isAndroid) {
      dir = "/storage/emulated/0/Download/";
    }
    path = "$dir/$uniqueFileName$fileName.jpg";
    return path;
  }

  Future<void> downloadFile(String url, String fileName, String fileNameAdd,
      DownloadProgressFileBloc downloadProgressFileBloc) async {
    progress = 0;

    String savePath = await getFilePath(fileName, fileNameAdd);
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

  final sendIndexTreningPhoto = SendIndexTreningPhoto();

  @override
  Widget build(BuildContext context) {
    final blocProgress = DownloadProgressFileBloc();
    final blocDetectTap = BlocDetectTap();
    final page = PageController(initialPage: 0);
    final token = Provider.of<String>(context);
    final treningiPhotos = Provider.of<TreningiPhotosProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: SizedBox(
        height: 325,
        width: 345,
        child: FutureBuilder<TreningiPhotosModel>(
            future: TreningiPhotosApi.getdata(treningiPhotos.getUrl, token),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 220,
                                maxWidth: 325,
                              ),
                              child: PageView.builder(
                                allowImplicitScrolling: true,
                                physics: const BouncingScrollPhysics(),
                                controller: page,
                                itemCount: snapshot.data!.data.data.list.length,
                                itemBuilder: (context, index) {
                                  log(index.toString());
                                  sendIndexTreningPhoto.setIndex(index - 1);

                                  return SizedBox(
                                    height: 220,
                                    width: 325,
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.data.data
                                          .list[index].picture_link,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              height: 220,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (page.hasClients &&
                                    page.offset <
                                        snapshot.data!.data.data.list.length *
                                            325) {
                                  page.previousPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.ease,
                                  );
                                }
                              },
                              child: Container(
                                height: 35,
                                width: 27,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                  ),
                                  color: Color(0xffff163e),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/back.png",
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                if (page.hasClients) {
                                  page.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.ease,
                                  );
                                }
                              },
                              child: Container(
                                height: 35,
                                width: 27,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topRight: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                  color: Color(0xffff163e),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/forward.png",
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 70,
                        width: 325,
                        color: const Color(0xffffffff),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: SizedBox(
                                width: 200,
                                child: Text(
                                  snapshot.data!.data.data.list[0].title,
                                  softWrap: true,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: StreamBuilder<double>(
                                  stream: blocProgress.stream,
                                  builder: (context, snapshotProgress) {
                                    return GestureDetector(
                                      onTap: () {
                                        log(sendIndexTreningPhoto.getIndex
                                            .toString());
                                        blocDetectTap.dataSink.add(true);
                                        if (snapshotProgress.data == null ||
                                            snapshotProgress.data == 0) {
                                          downloadFile(
                                              snapshot
                                                  .data!
                                                  .data
                                                  .data
                                                  .list[sendIndexTreningPhoto
                                                      .getIndex]
                                                  .picture_link,
                                              snapshot
                                                  .data!
                                                  .data
                                                  .data
                                                  .list[sendIndexTreningPhoto
                                                      .getIndex]
                                                  .title,
                                              sendIndexTreningPhoto.getIndex
                                                  .toString(),
                                              blocProgress);
                                        } else {}
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(64),
                                        child: Container(
                                          height: 25,
                                          width: 95,
                                          color: const Color(0xffff163e),
                                          child: Center(
                                            child: Text(
                                              "Скачать",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 10,
                                                color: const Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                    //////////////////////////////////////////////////////////////////////////
                    StreamBuilder<bool>(
                        stream: blocDetectTap.dataStream,
                        builder: (context, snapshotDetectTap) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: AnimatedContainer(
                                curve: snapshotDetectTap.data == true
                                    ? Curves.bounceOut
                                    : Curves.bounceOut,
                                duration: const Duration(milliseconds: 500),
                                width: 300,
                                height: snapshotDetectTap.data == true ? 20 : 0,
                                decoration: const BoxDecoration(
                                    color: Color(0xffffffff),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    )),
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity:
                                      snapshotDetectTap.data == true ? 1 : 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: StreamBuilder<double>(
                                        initialData: 0,
                                        stream: blocProgress.stream,
                                        builder: (context, snapshotDouble) {
                                          if (snapshotDouble.data == 100) {
                                            blocProgress.streamSink.add(0);
                                            blocDetectTap.dataSink.add(false);
                                          }
                                          return LinearPercentIndicator(
                                            alignment: MainAxisAlignment.center,
                                            padding: const EdgeInsets.all(0),
                                            barRadius: const Radius.circular(5),
                                            lineHeight: 6,
                                            percent: snapshotDouble.data! / 100,
                                            backgroundColor: Colors.transparent,
                                            progressColor: Colors.green,
                                          );
                                        }),
                                  ),
                                )),
                          );
                        }),
                    /////////////////////////////////////////////////////////////////////////
                  ],
                );
              } else {
                return const SizedBox();
              }
            }),
      ),
    );
  }
}
