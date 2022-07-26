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
    return Drawer(
      backgroundColor: const Color(0xFF2c2c2c),
        width: 324,
        child: Column(
          children: [
            Container(
              height: 283,
              width: 324,
              decoration: const BoxDecoration(color: Color(0xFF333333)),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 52, left: 26),
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF2d2d2d),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/192.png",
                        height: 46,
                        width: 46,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 39, left: 120),
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: Image.asset(
                            "assets/20181005-shefpovar.png",
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 170, top: 85),
                    child: Container(
                      height: 26,
                      width: 26,
                      decoration: BoxDecoration(
                        color: const Color(0xFFe21a37),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Color(0xFFffffff),
                        size: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 52, left: 247),
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
                              height: 46,
                              width: 46,
                              decoration: BoxDecoration(
                                color: const Color(0xFF686868),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xFF2d2d2d),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.favorite,
                                color: Color(0xFFffffff),
                              ),
                            ),
                          );
                        }),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 135, left: 123),
                    child: Text(
                      " Алексей\nКузнецов",
                      style: TextStyle(fontSize: 16, color: Color(0xFFffffff)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 183, left: 140),
                    child: Text(
                      "930",
                      style: GoogleFonts.montserrat(
                          fontSize: 23,
                          color: const Color(0xFFff0025),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 205, left: 131),
                    child: Text(
                      "баллов",
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: const Color(0xFFffffff),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 238, left: 82),
                    child: StreamBuilder<ActionChange>(
                      initialData: ActionChange.textIconCard,
                        stream: blocChangeProfileProvider.dataStream,
                        builder: (context, snapshot) {
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
                              height: 30,
                              width: 156,
                              decoration: BoxDecoration(
                                color:
                                    snapshot.data == ActionChange.textIconCard
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
                                    color: const Color(0xFF333333)
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
                                    fontSize: 12,
                                    color: const Color(0xFFffffff)),
                              ),
                            ),
                          );
                        }),
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
                                        : snapshot.data ==
                                                ActionChange.nastroyka
                                            ? true
                                            : false,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25, top: 238),
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
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color(0xFF25b049)),
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
              stream: blocChangeProfileProvider.dataStream,
              builder: (context, snapshot) {
                return Flexible(
                    child: ListView(
                  padding: const EdgeInsets.all(0),
                  children: List.generate(
                      1,
                      (index) => SizedBox(
                            height: snapshot.data == ActionChange.textIconCard
                                ? 500
                                : snapshot.data == ActionChange.personal
                                    ? 750
                                    : snapshot.data == ActionChange.izboreny
                                        ? 780
                                        : snapshot.data ==
                                                ActionChange.statistik
                                            ? 780
                                            : snapshot.data ==
                                                    ActionChange.personRekvizit
                                                ? 530
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
                                        : snapshot.data ==
                                                ActionChange.statistik
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
                                          : snapshot.data ==
                                                  ActionChange.personal
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
                                                          ? Wrap(
                                                              children: const [
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
                                                              : const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              39),
                                                                  child:
                                                                      TextIconCard(),
                                                                ),
                                  const SizedBox(
                                    height: 69,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 39),
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
                                      : const SizedBox(
                                          height: 20,
                                        ),
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
                                  const SizedBox(
                                    height: 20,
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
