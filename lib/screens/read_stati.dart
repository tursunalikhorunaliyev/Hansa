// ignore_for_file: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/read_stati_model.dart';
import 'package:hansa_app/blocs/read_stati_bloc.dart';
import 'package:hansa_app/extra/custom_title.dart';
import 'package:hansa_app/read_statie_section/stati_comment.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ReadStati extends StatelessWidget {
  ReadStati({Key? key}) : super(key: key);

  final ScrollController listViewController =
      ScrollController(keepScrollOffset: true);

  final Image iconImage = Image.asset(
    "assets/iconStati.png",
    width: 30.33333333333333,
    height: 30.33333333333333,
  );

  double positionDouble = 300.6666666666667;

  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    final readStatiModelProvider = Provider.of<ReadStatiBLoC>(context);
    positionDouble = isTablet?600:300;
    return StreamBuilder<ReadStatiModel>(
        stream: readStatiModelProvider.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [
                      CustomTitle(
                          imagePath: "assets/iconStati.png", title: "Статьи"),
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5.333333333333333),
                              topRight: Radius.circular(5.333333333333333)),
                          child: CachedNetworkImage(
                              imageUrl:
                                  snapshot.data!.article.read.pictureLink)),
                    ],
                  ),
                  SingleChildScrollView(
                    controller: listViewController,
                    physics: const BouncingScrollPhysics(),
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
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(3),
                                  topRight: Radius.circular(3)),
                              color: const Color(0xFFe9e9e9).withOpacity(.9)),
                          height: 7,
                          width: double.infinity,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.333333333333333),
                                  topRight: Radius.circular(5.333333333333333)),
                              color: Color(0xFFffffff)),
                          child: Wrap(children: [
                            Html(
                              data: snapshot.data!.article.read.body,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
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
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(.3),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            11.66666666666667),
                                                    color: const Color(
                                                        0xFFe21a37)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      snapshot.data!.article
                                                          .read.rating
                                                          .toString(),
                                                      style: GoogleFonts
                                                          .montserrat(
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
                                                "Коментариев  929       |",
                                                style: GoogleFonts.montserrat(
                                                  color:
                                                      const Color(0xFF777777),
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
                                        const SizedBox(
                                          height: 19.33333333333333,
                                        ),
                                        StatiComment(
                                            rating: snapshot
                                                .data!.article.read.rating
                                                .toString()),
                                        const SizedBox(
                                          height: 19.33333333333333,
                                        ),
                                        StatiComment(
                                            rating: snapshot
                                                .data!.article.read.rating
                                                .toString()),
                                        const SizedBox(
                                          height: 10,
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
                                                    color: Colors.black
                                                        .withOpacity(.3),
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
                                                  hintText:
                                                      "Интересно а почему именн...",
                                                  hintStyle:
                                                      GoogleFonts.montserrat(
                                                          fontSize:
                                                              12.66666666666667,
                                                          color: const Color(
                                                              0xFF919191))),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 300,
                                        )
                                      ],
                                    ),
                                  ]),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
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
                  Spacer()
                ],
              ),
            );
          }
        });
  }
}
