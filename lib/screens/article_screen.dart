// ignore_for_file: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/read_stati_model.dart';
import 'package:hansa_app/blocs/read_stati_bloc.dart';
import 'package:hansa_app/read_statie_section/part_indicator.dart';
import 'package:hansa_app/read_statie_section/stati_comment.dart';
import 'package:provider/provider.dart';

class ArticleScreen extends StatelessWidget {
  ArticleScreen({Key? key}) : super(key: key);

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
    final articleBloc = Provider.of<ReadStatiBLoC>(context);
    return StreamBuilder<ReadStatiModel>(
        stream: articleBloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [
                      PartIndicator(icon: iconImage),
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
                          child: Html(
                            data: snapshot.data!.article.read.body,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Center(
                child: SpinKitWanderingCubes(
              color: Colors.red,
            ));
          }
        });
  }
}