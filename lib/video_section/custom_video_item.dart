import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/blocs/bloc_play_video.dart';
import 'package:hansa_app/video/bloc_video_api.dart';
import 'package:hansa_app/video/model_video.dart';
import 'package:provider/provider.dart';

class CustomVideoListItem extends StatefulWidget {
  final int index;
  final int indexMain;

  const CustomVideoListItem(
      {Key? key, required this.index, required this.indexMain})
      : super(key: key);

  @override
  State<CustomVideoListItem> createState() => _CustomVideoListItemState();
}

class _CustomVideoListItemState extends State<CustomVideoListItem> {
  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    final playProvider = Provider.of<BlocPlayVideo>(context);
    final token = Provider.of<String>(context);
    final blocVideoApi = BlocVideoApi(token);
    blocVideoApi.eventSink.add(ActionVideo.view);
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 12, right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: isTablet ? 420 : 220,
          color: Colors.white,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: StreamBuilder<VideoMainOne>(
                    stream: blocVideoApi.dataStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: snapshot
                                  .data!
                                  .videoListData
                                  .list[widget.indexMain]
                                  .data
                                  .list[widget.index]
                                  .pictureLink,
                              height: isTablet ? 240 : 130,
                              width: isTablet ? 420 : 220,
                              fit: BoxFit.cover,
                            ),
                            InkWell(
                              onTap: () {
                                final VideoDetails video = snapshot
                                    .data!
                                    .videoListData
                                    .list[widget.indexMain]
                                    .data
                                    .list[widget.index];
                                playProvider.sink.add(
                                    [true, video.videoLink, video.title, true]);
                              },
                              child: Center(
                                child: Container(
                                  height: isTablet ? 240 : 130,
                                  width: isTablet ? 420 : 220,
                                  color: Colors.transparent,
                                  alignment: Alignment.center,
                                  child: Opacity(
                                    opacity: .5,
                                    child: Icon(
                                      CupertinoIcons.play_circle_fill,
                                      size: isTablet ? 45 : 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
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
                              fontSize: isTablet ? 16 : 10,
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
