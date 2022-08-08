import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/model_o_kompaniya.dart';
import 'package:hansa_app/blocs/bloc_o_kompaniya.dart';
import 'package:hansa_app/enums/enum_action_view.dart';
import 'package:hansa_app/extra/sobshit_o_problem.dart';
import 'package:provider/provider.dart';

class Okompaniya extends StatelessWidget {
  const Okompaniya({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    final providerToken = Provider.of<String>(context);
    final blocOKompaniya = BlocOKompaniya(providerToken);
    blocOKompaniya.eventSink.add(EnumActionView.view);
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: isTablet ? 95 : 67,
              decoration: const BoxDecoration(color: Color(0xFFf1f1f1)),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: isTablet ? 22 : 16,
                        left: isTablet ? 25 : 14,
                        right: isTablet ? 15 : 13,
                        bottom: isTablet ? 25 : 16),
                    height: isTablet ? 63 : 42,
                    width: isTablet ? 120 : 70,
                    decoration: const BoxDecoration(
                        color: Color(0xFFff163e),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(64),
                            bottomRight: Radius.circular(64))),
                    child: Image.asset(
                      "assets/Lab.png",
                    ),
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                  Text(
                    "#",
                    style: TextStyle(
                        color: Color(0xFFff163e),
                        fontWeight: FontWeight.bold,
                        fontSize: isTablet ? 20 : 16),
                  ),
                  Text(
                    "О компании ",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: isTablet ? 25 : 20),
                  )
                ],
              ),
            ),
            Stack(
              children: [
                isTablet
                    ? SizedBox()
                    : Container(
                        height: 217,
                        width: 375,
                        decoration:
                            const BoxDecoration(color: Color(0xFFf8f8f8)),
                      ),
                isTablet
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset(
                              "assets/o_kompaniya_image.png",
                              fit: BoxFit.fitWidth,
                              height: 425,
                              width: 850,
                            ),
                          ),
                        ],
                      )
<<<<<<< HEAD
                    : Image.asset("1649660637Аракелян Ася.png"),
=======
                    : Image.asset(
                        "assets/1649660637.png"),
>>>>>>> b7990e2bbac0c4405413b50786469e0cfd9b8010
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: isTablet ? 391 : 174),
                    child: Opacity(
                      opacity: 0.8,
                      child: Container(
                        height: isTablet ? 633 : 423,
                        width: isTablet ? 770 : 323,
                        decoration: BoxDecoration(
                            color: const Color(0xFFffffff),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: isTablet ? 405 : 184,
                    ),
                    child: Container(
                      height: isTablet ? 621 : 481,
                      width: isTablet ? 800 : 342,
                      decoration: BoxDecoration(
                          color: const Color(0xFFff163e),
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 70),
                            child: StreamBuilder<ModelOKompaniyaMain>(
                                stream: blocOKompaniya.dataStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                    
                                      snapshot.data!.data.title,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.fade,
                                      style: GoogleFonts.montserrat(
                                      
                                        fontSize: isTablet ? 26 : 16,
                                        color: const Color(0xFFffffff),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: isTablet ? 20 : 10,
                                top: 35,
                                right: isTablet ? 20 : 10),
                            child: StreamBuilder<ModelOKompaniyaMain>(
                                stream: blocOKompaniya.dataStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data!.data.list[0] +
                                          snapshot.data!.data.list[1] +
                                          snapshot.data!.data.list[2],
                                      style: TextStyle(
                                        fontSize: isTablet ? 21 : 11,
                                        color: Color(0xFFffffff),
                                      ),
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: isTablet ? 20 : 10,
                                top: 20,
                                right: isTablet ? 20 : 10),
                            child: Text(
                              "Это и социальная сеть, и место выкладки видеоматериала, и площадка для премирования лучших менеджеров по продажам, и средство коммуникации, и обучающий портал. Hansa LAB постоянно делится только самым интересным материалом, на основании которого проводятся конкурсы, тесты, вебинары.",
                              style: TextStyle(
                                fontSize: isTablet ? 21 : 11,
                                color: Color(0xFFffffff),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: isTablet ? 20 : 10,
                                top: 20,
                                right: isTablet ? 20 : 10),
                            child: Text(
                              "Данный проект призван объединить менеджеров по продажам КБТ со всей страны в одно единое целое ядро",
                              style: TextStyle(
                                fontSize: isTablet ? 21 : 11,
                                color: Color(0xFFffffff),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: isTablet ? 900 : 593,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => const SobshitOProblem(),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: isTablet ? 65 : 31,
                        width: isTablet ? 540 : 213,
                        decoration: BoxDecoration(
                          color: const Color(0xFF25b049),
                          borderRadius: BorderRadius.circular(70),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFda1335).withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Text(
                          "Написать разработчику",
                          style: GoogleFonts.montserrat(
                              fontSize: isTablet ? 19 : 12,
                              color: const Color(0xFFffffff)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
