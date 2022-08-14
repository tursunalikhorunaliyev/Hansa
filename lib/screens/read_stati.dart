import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/read_stati_model.dart';
import 'package:hansa_app/api_models.dart/stati_comment_model.dart';
import 'package:hansa_app/blocs/bloc_comment_stati.dart';
import 'package:hansa_app/blocs/read_stati_bloc.dart';
import 'package:hansa_app/extra/custom_title.dart';
import 'package:hansa_app/providers/stati_id_provider.dart';
import 'package:hansa_app/read_statie_section/stati_comment.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ReadStati extends StatelessWidget {
  ReadStati({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double positionDouble = 300.6666666666667;
    String link = "";
    final token = Provider.of<String>(context);
    final isTablet = Provider.of<bool>(context);
    final readStatiModelProvider = Provider.of<ReadStatiBLoC>(context);
    final blocForStatiComment = BlocForStatiComment();
    final statiIdProvider = Provider.of<StatiIdProvider>(context);
    positionDouble = isTablet ? 600 : 300;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<ReadStatiModel>(
                future: readStatiModelProvider.getReadStati(
                    token, statiIdProvider.getUrl),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    link = snapshot.data!.article.read.messages;
                    return Stack(
                      children: [
                        Column(
                          children: [
                            CustomTitle(
                                imagePath: "assets/iconStati.png",
                                title: "Статьи"),
                            ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5.333333333333333),
                                    topRight:
                                        Radius.circular(5.333333333333333)),
                                child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.article.read.pictureLink)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 12.33333333333333,
                            right: 12.33333333333333,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: positionDouble,
                                width: double.infinity,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(3),
                                        topRight: Radius.circular(3)),
                                    color: const Color(0xFFe9e9e9)
                                        .withOpacity(.9)),
                                height: 7,
                                width: double.infinity,
                              ),
                              Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft:
                                            Radius.circular(5.333333333333333),
                                        topRight:
                                            Radius.circular(5.333333333333333)),
                                    color: Color(0xFFffffff)),
                                child: Html(
                                  data: snapshot.data!.article.read.body,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  } else {
                    return Expanded(
                      child: Column(
                        children: [
                          Spacer(),
                          Lottie.asset(
                            'assets/pre.json',
                            height: 70,
                            width: 70,
                          ),
                          Spacer(),
                        ],
                      ),
                    );
                  }
                }),
            FutureBuilder<StatiComentModel>(
                future: blocForStatiComment.getComment(link, token),
                builder: (context, snapshota) {
                  if (snapshota.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Flex(
                            direction: Axis.vertical,
                            children: [
                              Container(
                                height: 54.66666666666667,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: const Color(0xFFffffff),
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(.3),
                                          blurRadius: 30,
                                          offset: const Offset(3, 7))
                                    ]),
                                child: Row(
                                  mainAxisAlignment: isTablet
                                      ? MainAxisAlignment.spaceEvenly
                                      : MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: isTablet ? 20 : 0,
                                    ),
                                    Container(
                                      height: 32.22333333333333,
                                      width: 82.40333333333333,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              11.66666666666667),
                                          color: const Color(0xFFe21a37)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '1.1',
                                            style: GoogleFonts.montserrat(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.star,
                                            size: 14,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: isTablet ? 15 : 0,
                                    ),
                                    Text(
                                      "Коментариев  ${snapshota.data!.data.list.length}       |",
                                      style: GoogleFonts.montserrat(
                                        color: const Color(0xFF777777),
                                        fontSize: 13.81,
                                      ),
                                    ),
                                    isTablet ? Spacer() : SizedBox(),
                                    SizedBox(
                                      height: 46.03666666666667,
                                      width: 46.03666666666667,
                                      child: Image.asset(
                                        "assets/imageLAB.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: isTablet ? 20 : 0,
                                    )
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: List.generate(
                                    snapshota.data!.data.list.length,
                                    (index) => Column(
                                      children: [
                                        StatiComment(
                                          rating: snapshota
                                              .data!.data.list[index].rang
                                              .toString(),
                                          name: snapshota
                                              .data!.data.list[index].fullname,
                                          comment: snapshota
                                              .data!.data.list[index].body,
                                          imageURl: snapshota.data!.data
                                              .list[index].picture_link,
                                        ),
                                        const SizedBox(
                                          height: 19.33333333333333,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text(
                                      "#",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      "Написать комментарий",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10.66666666666667,
                              ),
                              Container(
                                height: 138,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: const Color(0xFFffffff),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(.3),
                                          blurRadius: 7,
                                          offset: const Offset(0, 8))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextField(
                                    maxLines: 7,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Интересно а почему именн...",
                                        hintStyle: GoogleFonts.montserrat(
                                            fontSize: 12.66666666666667,
                                            color: const Color(0xFF919191))),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 300,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Lottie.asset(
                        'assets/pre.json',
                        height: 70,
                        width: 70,
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
