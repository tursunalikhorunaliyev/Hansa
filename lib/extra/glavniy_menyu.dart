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
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      width: isTablet ? 180.w : 324.w,
      child: Column(
        children: [
          Container(
            height: 283.h,
            width: isTablet ? 185.w : 324.w,
            decoration: const BoxDecoration(color: Color(0xFF333333)),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: isTablet ? 70.h : 52.h,
                      left: isTablet ? 10.w : 26.w),
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
                      height: isTablet ? 38.h : 46.h,
                      width: isTablet ? 38.w : 46.w,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: isTablet ? 63.h : 39.h,
                      left: isTablet ? 32.w : 120.w),
                  child: SizedBox(
                    height: isTablet ? 100.h : 80.h,
                    width: isTablet ? 100.w : 80.w,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(80.r),
                        child: Image.asset(
                          isTablet
                              ? "assets/shef_povar_oval.png"
                              : "assets/20181005-shefpovar.png",
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: isTablet ? 83.w : 170.w,
                      top: isTablet ? 100.h : 85.h),
                  child: Container(
                    height: isTablet ? 26.h : 26.h,
                    width: isTablet ? 26.w : 26.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFe21a37),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: const Color(0xFFffffff),
                      size: isTablet ? 10.sp : 20.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: isTablet ? 70.h : 52.h,
                      left: isTablet ? 114.w : 247.w),
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
                            height: isTablet ? 38.h : 46.h,
                            width: isTablet ? 38.w : 46.w,
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
                            child: const Icon(
                              Icons.favorite,
                              color: Color(0xFFffffff),
                            ),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: isTablet ? 135.h : 135.h,
                      left: isTablet ? 60.w : 123.w),
                  child: Text(
                    " Алексей\nКузнецов",
                    style: TextStyle(
                        fontSize: isTablet ? 10.sp : 16.sp,
                        color: const Color(0xFFffffff)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: isTablet ? 178.h : 183.h,
                      left: isTablet ? 70.w : 140.w),
                  child: Text(
                    "930",
                    style: GoogleFonts.montserrat(
                        fontSize: isTablet ? 13.sp : 23.sp,
                        color: const Color(0xFFff0025),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: isTablet ? 200.h : 205.h,
                      left: isTablet ? 66.w : 131.w),
                  child: Text(
                    "баллов",
                    style: GoogleFonts.montserrat(
                        fontSize: isTablet ? 9.sp : 16.sp,
                        color: const Color(0xFFffffff),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: isTablet ? 230.h : 238.h,
                          left: isTablet ? 45.w : 82.w),
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
                                height: isTablet ? 28.h : 30.h,
                                width: isTablet ? 80.w : 156.w,
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
                                      fontSize: isTablet ? 6.sp : 12.sp,
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
                            left: 25, top: isTablet ? 349 : 238),
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
                                color:  Color(0xFF25b049)),
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
                          height: isTablet
                              ? 529.h
                              : snapshot.data == ActionChange.textIconCard
                                  ? 500
                                  : snapshot.data == ActionChange.personal
                                      ? 750
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
                                                            : const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            39),
                                                                child:
                                                                    TextIconCard(),
                                                              ),
                                SizedBox(
                                  height: isTablet ? 150.h : 69.h,
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
