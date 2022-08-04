import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/rating_top_model.dart';
import 'package:hansa_app/api_services/rating_top_api.dart';
import 'package:hansa_app/drawer_widgets/drawer_stat_title.dart';
import 'package:provider/provider.dart';

class DrawerStats extends StatelessWidget {
  const DrawerStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<String>(context);
    final bloc = BlocRating(prov);
    bloc.eventSink.add(RatingEnum.rating);
    return Container(
      color: const Color(0xFFffffff),
      child: Column(
        children: [
          const DrawerStatTitle(
            imagePath: "assets/free-icon-rating-4569150.png",
            title: "Статистика",
          ),
          SizedBox(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DataTable(
                    headingRowHeight: 20,
                    columnSpacing: 10,
                    dataRowHeight: 31,
                    horizontalMargin: 1,
                    columns: [
                      DataColumn(
                        label: Text(
                          "Место",
                          style: GoogleFonts.montserrat(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Сеть",
                          style: GoogleFonts.montserrat(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Участник",
                          style: GoogleFonts.montserrat(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Баллы",
                          style: GoogleFonts.montserrat(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    rows: List.generate(
                      10,
                      (index) => DataRow(
                        color: MaterialStateProperty.all(
                          (index == 9) ? const Color(0xffe21a37) : Colors.white,
                        ),
                        cells: [
                          DataCell(
                            Text(
                              "${index + 1}",
                              style: GoogleFonts.montserrat(
                                  fontSize: 8,
                                  fontWeight: FontWeight.normal,
                                  color: (index == 9)
                                      ? const Color(0xffffffff)
                                      : const Color(0xff353433)),
                            ),
                          ),
                          DataCell(
                            StreamBuilder<RatingTopModel>(
                                stream: bloc.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data!.data.list[index].shop_net,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 8,
                                          fontWeight: FontWeight.normal,
                                          color: (index == 9)
                                              ? const Color(0xffffffff)
                                              : const Color(0xff353433)),
                                    );
                                  } else {
                                    return const Center(child: SizedBox());
                                  }
                                }),
                          ),
                          DataCell(
                            StreamBuilder<RatingTopModel>(
                                stream: bloc.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data!.data.list[index].name,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 8,
                                          fontWeight: FontWeight.normal,
                                          color: (index == 9)
                                              ? const Color(0xffffffff)
                                              : const Color(0xff353433)),
                                    );
                                  } else {
                                    return const Center(child: SizedBox());
                                  }
                                }),
                          ),
                          DataCell(
                            StreamBuilder<RatingTopModel>(
                                stream: bloc.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data!.data.list[index].score,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 8,
                                          fontWeight: FontWeight.normal,
                                          color: (index == 9)
                                              ? const Color(0xffffffff)
                                              : const Color(0xff353433)),
                                    );
                                  } else {
                                    return const Center(child: SizedBox());
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            child: GestureDetector(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(64),
                child: Container(
                  width: 160,
                  height: 30,
                  color: const Color(0xffe21a37),
                  child: Center(
                    child: Text(
                      "Весь рейтинг",
                      style: GoogleFonts.montserrat(
                        fontSize: 11.5,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
