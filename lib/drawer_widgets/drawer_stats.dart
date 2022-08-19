import 'package:flutter/cupertino.dart';
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
  final scroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<String>(context);
    final bloc = BlocRating();
    final isTablet = Provider.of<bool>(context);
    final fullname = Provider.of<FullnameProvider>(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        // height: isTablet ? 650 : null,
        color: const Color(0xFFffffff),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const DrawerStatTitle(
                  imagePath: "assets/free-icon-rating-4569150.png",
                  title: "Статистика",
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: InkWell(
                    onTap: () {
                      scroll.animateTo(0,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.fastLinearToSlowEaseIn);
                    },
                    child: const Icon(CupertinoIcons.chevron_up_circle_fill,
                        color: Color(0xffe21a37), size: 25),
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  height: 330,
                  child: FutureBuilder<RatingTopModel>(
                      future: bloc.getStores(prov),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SingleChildScrollView(
                            controller: scroll,
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
                                ),
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
                                  snapshot.data!.data.list.length, (index) {
                                bool thisUser = snapshot
                                        .data!.data.list[index].name ==
                                    "${fullname.getName.split(' ').last} ${fullname.getName.split(' ').first}";
                                return DataRow(
                                  color: MaterialStateProperty.all(
                                    thisUser
                                        ? const Color(0xffe21a37)
                                        : Colors.white,
                                  ),
                                  cells: [
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${index + 1}",
                                          style: GoogleFonts.montserrat(
                                              fontSize: isTablet ? 13 : 8,
                                              fontWeight: FontWeight.normal,
                                              color: thisUser
                                                  ? Colors.white
                                                  : const Color(0xff353433)),
                                        ),
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
                                    DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        snapshot.data!.data.list[index].score,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 8,
                                            fontWeight: FontWeight.normal,
                                            color: thisUser
                                                ? Colors.white
                                                : const Color(0xff353433)),
                                      ),
                                    )),
                                  ],
                                );
                              }),
                            ),
                          );
                        } else {
                          return const SizedBox(
                            height: 330,
                            child: SpinKitPulse(
                              color: Color(0xffe21a37),
                            ),
                          );
                        }
                      }),
                )),
            /* Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  isCollapsed = isCollapsed ? false : true;
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: isTablet ? 34 : 20,
                  width: isTablet ? 200 : 100,
                  decoration: BoxDecoration(
                    color: const Color(0xffe21a37),
                    borderRadius: BorderRadius.circular(70),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0XFFDBDBDB),
                          blurRadius: 5,
                          spreadRadius: 4,
                          offset: Offset(0, 4) // changes position of shadow
                          ),
                    ],
                  ),
                  child: Text(
                    isCollapsed ? "Только топ 10" : "Весь рейтинг",
                    style: GoogleFonts.montserrat(
                        fontSize: isTablet ? 16 : 9,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFffffff)),
                  ),
                ),
              ),
            ), */
          ],
        ),
      ),
    );
  }
}
