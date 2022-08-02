import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/blocs/bloc_change_profile.dart';
import 'package:hansa_app/drawer_widgets/change_profile.dart';
import 'package:hansa_app/drawer_widgets/drawer_stats.dart';
import 'package:hansa_app/drawer_widgets/izbrannoe.dart';
import 'package:hansa_app/drawer_widgets/nastroyka_widget.dart';
import 'package:hansa_app/drawer_widgets/personalniy_daniy.dart';
import 'package:hansa_app/drawer_widgets/referal_silka.dart';
import 'package:hansa_app/drawer_widgets/rekvizit.dart';
import 'package:hansa_app/drawer_widgets/text_icon.dart';
import 'package:hansa_app/drawer_widgets/text_icon_card.dart';
import 'package:provider/provider.dart';

class GlavniyMenyu extends StatefulWidget {

  const GlavniyMenyu({Key? key}) : super(key: key);

  @override
  State<GlavniyMenyu> createState() => _GlavniyMenyuState();
}

class _GlavniyMenyuState extends State<GlavniyMenyu> {
  GlobalKey<ScaffoldState> keyScaffold = GlobalKey();
  
  
  @override
  Widget build(BuildContext context) {
    final blocChangeProfileProvider = Provider.of<BlocChangeProfile>(context);
    final isTablet = Provider.of<bool>(context);

    return Drawer(
      backgroundColor: const Color(0xFF333333),
      width: isTablet ? 435 : 324,
      child: Column(
        children: [
          Container(
            height: isTablet ? 400 : 283,
            width: isTablet ? 450 : 324,
            decoration: const BoxDecoration(color: Color(0xFF333333)),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: isTablet ? 70 : 52, left: isTablet ? 40 : 26),
                  child: Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF2d2d2d),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                          // changes position of shadow
                        ),
                      ],
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      "assets/192.png",
                      height: isTablet ? 60 : 46,
                      width: isTablet ? 60 : 46,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: isTablet ? 60 : 39, left: isTablet ? 120 : 120),
                  child: SizedBox(
                    height: isTablet ? 180 : 80,
                    width: isTablet ? 180 : 80,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.asset(
                          isTablet
                              ? "assets/shef_povar_oval.png"
                              : "assets/20181005-shefpovar.png",
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: isTablet ? 125 : 85,
                    left: isTablet ? 240 : 170,
                  ),
                  child: Container(
                    height: isTablet ? 33 : 26,
                    width: isTablet ? 33 : 26,
                    decoration: const BoxDecoration(
                      color: Color(0xFFe21a37),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: const Color(0xFFffffff),
                      size: isTablet ? 20 : 20,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: isTablet ? 70 : 52, left: isTablet ? 320 : 247),
                  child: StreamBuilder<ActionChange>(
                      initialData: ActionChange.textIconCard,
                      stream: blocChangeProfileProvider.dataStream,
                      builder: (context, snapshot) {
                        return GestureDetector(
                          onTap: () {
                            snapshot.data == ActionChange.izboreny
                                ? blocChangeProfileProvider.dataSink
                                    .add(ActionChange.textIconCard)
                                : blocChangeProfileProvider.dataSink
                                    .add(ActionChange.izboreny);
                          },
                          child: Container(
                            height: isTablet ? 60 : 46,
                            width: isTablet ? 60 : 46,
                            decoration: const BoxDecoration(
                              color: Color(0xFF686868),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF2d2d2d),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.favorite,
                              color: const Color(0xFFffffff),
                              size: isTablet ? 40 : 20,
                            ),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: isTablet ? 180 : 135, left: isTablet ? 163 : 123),
                  child: Text(
                    " Алексей\nКузнецов",
                    style: TextStyle(
                        fontSize: isTablet ? 23 : 16,
                        color: const Color(0xFFffffff)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: isTablet ? 245 : 183, left: isTablet ? 185 : 140),
                  child: Text(
                    "930",
                    style: GoogleFonts.montserrat(
                        fontSize: isTablet ? 30 : 23,
                        color: const Color(0xFFff0025),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: isTablet ? 280 : 205, left: isTablet ? 175 : 131),
                  child: Text(
                    "баллов",
                    style: GoogleFonts.montserrat(
                        fontSize: isTablet ? 20 : 16,
                        color: const Color(0xFFffffff),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: isTablet ? 320 : 238, left: isTablet ? 118 : 82),
                      child: StreamBuilder<ActionChange>(
                          initialData: ActionChange.textIconCard,
                          stream: blocChangeProfileProvider.dataStream,
                          builder: (context, snapshot) {
                            log(snapshot.data!.name);
                            return GestureDetector(
                              onTap: () {
                                snapshot.data == ActionChange.personRekvizit
                                    ? blocChangeProfileProvider.dataSink
                                        .add(ActionChange.textIconCard)
                                    : blocChangeProfileProvider.dataSink
                                        .add(ActionChange.personRekvizit);

                                if (snapshot.data == ActionChange.nastroyka) {
                                  blocChangeProfileProvider.dataSink
                                      .add(ActionChange.textIconCard);
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: isTablet ? 40 : 30,
                                width: isTablet ? 200 : 156,
                                decoration: BoxDecoration(
                                  color: snapshot.data ==
                                          ActionChange.textIconCard
                                      ? const Color(0xFFe21a37)
                                      : snapshot.data == ActionChange.izboreny
                                          ? const Color(0xFFe21a37)
                                          : snapshot.data ==
                                                  ActionChange.statistik
                                              ? const Color(0xFFe21a37)
                                              : const Color(0xFF25b049),
                                  borderRadius: BorderRadius.circular(70),
                                  boxShadow: [
                                    BoxShadow(
                                      color: isTablet
                                          ? const Color(0xFF2c2c2c)
                                          : const Color(0xFF333333)
                                              .withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Text(
                                  snapshot.data == ActionChange.textIconCard
                                      ? "Редактировать"
                                      : snapshot.data == ActionChange.izboreny
                                          ? "Редактировать"
                                          : snapshot.data ==
                                                  ActionChange.statistik
                                              ? "Редактировать"
                                              : "Сохранить",
                                  style: GoogleFonts.montserrat(
                                      fontSize: isTablet ? 16 : 12,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFffffff)),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
                StreamBuilder<ActionChange>(
                  stream: blocChangeProfileProvider.dataStream,
                  builder: (context, snapshot) {
                    return Visibility(
                      visible: snapshot.data == ActionChange.rekvizit
                          ? true
                          : snapshot.data == ActionChange.personal
                              ? true
                              : snapshot.data == ActionChange.izboreny
                                  ? true
                                  : snapshot.data == ActionChange.statistik
                                      ? true
                                      : snapshot.data == ActionChange.nastroyka
                                          ? true
                                          : snapshot.data ==
                                                  ActionChange.personRekvizit
                                              ? true
                                              : false,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: isTablet ? 55 : 25,
                            top: isTablet ? 320 : 238),
                        child: GestureDetector(
                          onTap: () {
                            if (snapshot.data == ActionChange.izboreny) {
                              blocChangeProfileProvider.dataSink
                                  .add(ActionChange.textIconCard);
                            }
                            if (snapshot.data == ActionChange.personal) {
                              blocChangeProfileProvider.dataSink
                                  .add(ActionChange.personRekvizit);
                            }
                            if (snapshot.data == ActionChange.rekvizit) {
                              blocChangeProfileProvider.dataSink
                                  .add(ActionChange.personRekvizit);
                            }
                            if (snapshot.data == ActionChange.statistik) {
                              blocChangeProfileProvider.dataSink
                                  .add(ActionChange.textIconCard);
                            }
                            if (snapshot.data == ActionChange.nastroyka) {
                              blocChangeProfileProvider.dataSink
                                  .add(ActionChange.textIconCard);
                            }
                            if (snapshot.data == ActionChange.personRekvizit) {
                              blocChangeProfileProvider.dataSink
                                  .add(ActionChange.textIconCard);
                            }
                          },
                          child: Container(
                            height: isTablet ? 40 : 30,
                            width: isTablet ? 40 : 30,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF25b049)),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Image.asset(
                                  "assets/free-icon-right-arrow-152352.png"),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          StreamBuilder<ActionChange>(
            initialData: ActionChange.textIconCard,
            stream: blocChangeProfileProvider.dataStream,
            builder: (context, snapshot) {
              return Flexible(
                  child: ListView(
                padding: const EdgeInsets.all(0),
                children: List.generate(
                    1,
                    (index) => SizedBox(
                          height:  snapshot.data == ActionChange.textIconCard
                                  ? isTablet ? 820  : 500
                                  : snapshot.data == ActionChange.personal
                                      ? isTablet ? 800  : 750
                                      : snapshot.data == ActionChange.izboreny
                                          ? 780
                                          : snapshot.data ==
                                                  ActionChange.statistik
                                              ? 780
                                              : snapshot.data ==
                                                      ActionChange
                                                          .personRekvizit
                                                  ? isTablet
                                                      ? 3000
                                                      : 530
                                                  : snapshot.data ==
                                                          ActionChange.rekvizit
                                                      ? 780
                                                      : snapshot.data ==
                                                              ActionChange
                                                                  .nastroyka
                                                          ? 550
                                                          : 528,
                          child: Container(
                            padding: EdgeInsets.only(
                              top: snapshot.data == ActionChange.rekvizit
                                  ? 0
                                  : snapshot.data == ActionChange.izboreny
                                      ? 0
                                      : snapshot.data == ActionChange.statistik
                                          ? 0
                                          : 20,
                            ),
                            decoration:
                                const BoxDecoration(color: Color(0xFF2c2c2c)),
                            child: Column(
                              children: [
                                snapshot.data == ActionChange.personRekvizit
                                    ? const ChangeProfile()
                                    : snapshot.data == ActionChange.izboreny
                                        ? Wrap(
                                            children: const [
                                              Izbrannoe(),
                                              SizedBox(
                                                height: 509,
                                              ),
                                              ReferalSilka(),
                                            ],
                                          )
                                        : snapshot.data == ActionChange.personal
                                            ? const PersonalniyDaniy()
                                            : snapshot.data ==
                                                    ActionChange.statistik
                                                ? Wrap(
                                                    children: const [
                                                      DrawerStats(),
                                                      SizedBox(
                                                        height: 509,
                                                      ),
                                                      ReferalSilka(),
                                                    ],
                                                  )
                                                : snapshot.data ==
                                                        ActionChange.rekvizit
                                                    ? Wrap(children: const [
                                                        Rekvizit(),
                                                        SizedBox(
                                                          height: 509,
                                                        ),
                                                        ReferalSilka()
                                                      ])
                                                    : snapshot.data ==
                                                            ActionChange
                                                                .statistik
                                                        ? Wrap(children: const [
                                                            DrawerStats(),
                                                            SizedBox(
                                                              height: 509,
                                                            ),
                                                            ReferalSilka()
                                                          ])
                                                        : snapshot.data ==
                                                                ActionChange
                                                                    .nastroyka
                                                            ? const NastroykaWidget()
                                                            :      const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            39),
                                                                child:
                                                                    TextIconCard(),
                                                              ),
                                snapshot.data == ActionChange.personRekvizit
                                    ? SizedBox(
                                        height: isTablet ? 50 : 69,
                                      )
                                    : snapshot.data == ActionChange.personal
                                        ? SizedBox(
                                            height: isTablet ? 407 : 69,
                                          )
                                        : SizedBox(
                                            height: isTablet ? 200 : 69,
                                          ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 39,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      blocChangeProfileProvider.dataSink
                                          .add(ActionChange.statistik);
                                    },
                                    child: TextIcon(
                                      text: "Статистика",
                                      iconUrl:
                                          "assets/free-icon-rating-4569150.png",
                                    ),
                                  ),
                                ),
                                snapshot.data == ActionChange.nastroyka
                                    ? const SizedBox(
                                        height: 0,
                                      )
                                    : SizedBox(height: isTablet ? 40 : 20),
                                snapshot.data == ActionChange.nastroyka
                                    ? const SizedBox(
                                        height: 0,
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(left: 39),
                                        child: GestureDetector(
                                          onTap: () {
                                            blocChangeProfileProvider.dataSink
                                                .add(ActionChange.nastroyka);
                                          },
                                          child: TextIcon(
                                            text: "Настройки",
                                            iconUrl: "assets/icon.png",
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  height: isTablet ? 40 : 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 39),
                                  child: TextIcon(
                                    text: "Выход из акаунта",
                                    iconUrl: "assets/iconiu.png",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
              ));
            },
          )
        ],
      ),
    );
  }
}
