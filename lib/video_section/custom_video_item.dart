import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/blocs/bloc_play_video.dart';
import 'package:hansa_app/video/bloc_video_api.dart';
import 'package:hansa_app/video/model_video.dart';
import 'package:provider/provider.dart';

class CustomVideoListItem extends StatefulWidget {
  int index;
  int indexMain;

  CustomVideoListItem({Key? key, required this.index, required this.indexMain})
      : super(key: key);

  @override
  State<CustomVideoListItem> createState() => _CustomVideoListItemState();
}

class _CustomVideoListItemState extends State<CustomVideoListItem> {
  @override
  Widget build(BuildContext context) {
    final playProvider = Provider.of<BlocPlayVideo>(context);
    final token = Provider.of<String>(context);
    final blocVideoApi = BlocVideoApi(token);
    blocVideoApi.eventSink.add(ActionVideo.View);

    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 12, right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 155,
          color: Colors.white,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  playProvider.sink.add(true);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      StreamBuilder<VideoMainOne>(
                          stream: blocVideoApi.dataStream,
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return const SizedBox();
                            } else {
                              return Image.network(
                                snapshot
                                    .data!
                                    .videoListData
                                    .list[widget.indexMain]
                                    .data
                                    .list[widget.index]
                                    .pictureLink,
                                height: 130,
                                width: 155,
                                fit: BoxFit.cover,
                              );
                            }
                          }),
                      Container(
                        height: 130,
                        width: 155,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: const Opacity(
                          opacity: .5,
                          child: Icon(
                            CupertinoIcons.play_circle_fill,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              StreamBuilder<VideoMainOne>(
                  stream: blocVideoApi.dataStream,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const SizedBox();
                    } else {
                      return Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(11),
                        child: Text(
                          snapshot.data!.videoListData.list[widget.indexMain]
                              .data.list[widget.index].title,
                          maxLines: 3,
                          style: GoogleFonts.montserrat(
                              fontSize: 10,
                              color: const Color(0xff4e5258),
                              fontWeight: FontWeight.w600),
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
