import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/rating_top_model.dart';
import 'package:hansa_app/api_services/rating_top_api.dart';
import 'package:hansa_app/drawer_widgets/drawer_stat_title.dart';
import 'package:hansa_app/providers/fullname_provider.dart';
import 'package:provider/provider.dart';

class DrawerStats extends StatefulWidget {
  const DrawerStats({Key? key}) : super(key: key);

  @override
  State<DrawerStats> createState() => _DrawerStatsState();
}

class _DrawerStatsState extends State<DrawerStats> {
  bool isCollapsed = false;
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<String>(context);
    final bloc = BlocRating(prov);
    final isTablet = Provider.of<bool>(context);
    bloc.eventSink.add(RatingEnum.rating);
    final fullname = Provider.of<FullnameProvider>(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        // height: isTablet ? 650 : null,
        color: const Color(0xFFffffff),
        child: Column(
          children: [
            const DrawerStatTitle(
              imagePath: "assets/free-icon-rating-4569150.png",
              title: "Статистика",
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  height: isTablet ? 500 : null,
                  child: StreamBuilder<RatingTopModel>(
                      stream: bloc.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SingleChildScrollView(
                            child: DataTable(
                              headingRowHeight: 20,
                              columnSpacing: 10,
                              dataRowHeight: isTablet ? 45 : 30,
                              horizontalMargin: 1,
                              columns: [
                                DataColumn(
                                    label: Text(
                                      "Место",
                                      style: GoogleFonts.montserrat(
                                        fontSize: isTablet ? 14 : 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    numeric: false),
                                DataColumn(
                                  label: Text(
                                    "Сеть",
                                    style: GoogleFonts.montserrat(
                                      fontSize: isTablet ? 14 : 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Участник",
                                    style: GoogleFonts.montserrat(
                                      fontSize: isTablet ? 14 : 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Баллы",
                                    style: GoogleFonts.montserrat(
                                      fontSize: isTablet ? 14 : 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                              rows: List.generate(
                                  isCollapsed
                                      ? snapshot.data!.data.list.length
                                      : 10, (index) {
                                bool thisUser =
                                    snapshot.data!.data.list[index].name ==
                                        fullname.getName.split(' ').last +
                                            " " +
                                            fullname.getName.split(' ').first;
                                log(snapshot.data!.data.list[index].name);
                                return DataRow(
                                  color: MaterialStateProperty.all(
                                    thisUser ? Color(0xffe21a37) : Colors.white,
                                  ),
                                  cells: [
                                    DataCell(
                                      Text(
                                        "${index + 1}",
                                        style: GoogleFonts.montserrat(
                                            fontSize: isTablet ? 13 : 8,
                                            fontWeight: FontWeight.normal,
                                            color: thisUser
                                                ? Colors.white
                                                : const Color(0xff353433)),
                                      ),
                                    ),
                                    DataCell(Text(
                                      snapshot.data!.data.list[index].shop_net,
                                      style: GoogleFonts.montserrat(
                                          fontSize: isTablet ? 12 : 8,
                                          fontWeight: FontWeight.normal,
                                          color: thisUser
                                              ? Colors.white
                                              : const Color(0xff353433)),
                                    )),
                                    DataCell(Text(
                                      snapshot.data!.data.list[index].name,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 8,
                                          fontWeight: FontWeight.normal,
                                          color: thisUser
                                              ? Colors.white
                                              : const Color(0xff353433)),
                                    )),
                                    DataCell(Text(
                                      snapshot.data!.data.list[index].score,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 8,
                                          fontWeight: FontWeight.normal,
                                          color: thisUser
                                              ? Colors.white
                                              : const Color(0xff353433)),
                                    )),
                                  ],
                                );
                              }),
                            ),
                          );
                        } else {
                          return SizedBox(
                            height: 330,
                            child: SpinKitPulse(
                              color: Color(0xffe21a37),
                            ),
                          );
                        }
                      }),
                )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  isCollapsed = isCollapsed ? false : true;
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: isTablet ? 34 : 30,
                  width: isTablet ? 200 : 140,
                  decoration: BoxDecoration(
                    color: const Color(0xFF25b049),
                    borderRadius: BorderRadius.circular(70),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0XFFDBDBDB),
                          blurRadius: 5,
                          spreadRadius: 4,
                          offset: Offset(0, 4) // changes position of shadow
                          ),
                    ],
                  ),
                  child: Text(
                    isCollapsed ? "показать меньше" : "показать ещё",
                    style: GoogleFonts.montserrat(
                        fontSize: isTablet ? 16 : 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFffffff)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
