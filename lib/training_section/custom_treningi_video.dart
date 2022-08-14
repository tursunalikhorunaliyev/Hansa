import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/blocs/download_progress_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class CustomTreningiVideo extends StatelessWidget {
  final String title;
  VoidCallback onTap;
  CustomTreningiVideo({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocDownload = Provider.of<DownloadProgressFileBloc>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Column(
        children: [
          const SizedBox(
            height: 11,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 100,
              width: 355,
              color: const Color(0xffffffff),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            title,
                            overflow: TextOverflow.clip,
                            softWrap: true,
                            maxLines: 3,
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
                        child: GestureDetector(
                          onTap: onTap,
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
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: StreamBuilder<double>(
                        initialData: 0,
                        stream: blocDownload.stream,
                        builder: (context, snapshotDouble) {
                          return LinearPercentIndicator(
                            alignment: MainAxisAlignment.center,
                            padding: const EdgeInsets.all(0), 
                            barRadius: Radius.circular(5),
                            lineHeight: 6,
                            percent: snapshotDouble.data! / 100,
                            backgroundColor: Colors.transparent,
                            progressColor: Colors.green,
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
