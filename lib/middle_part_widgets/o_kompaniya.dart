import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/sobshit_o_problem.dart';

class Okompaniya extends StatelessWidget {
  const Okompaniya({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 67,
              decoration: const BoxDecoration(color: Color(0xFFf1f1f1)),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 16, left: 14, right: 13, bottom: 16),
                    height: 42,
                    width: 70,
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
                  const Text(
                    "#",
                    style: TextStyle(color: Color(0xFFff163e), fontSize: 16),
                  ),
                  Text(
                    "О компании ",
                    style: GoogleFonts.montserrat(fontSize: 20),
                  )
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 217,
                  width: 375,
                  decoration: const BoxDecoration(color: Color(0xFFf8f8f8)),
                ),
                Image.asset("assets/1649660637Аракелян Ася.jpg.png"),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 174),
                    child: Opacity(
                      opacity: 0.8,
                      child: Container(
                        height: 423,
                        width: 323,
                        decoration: BoxDecoration(
                            color: const Color(0xFFffffff),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 184,
                    ),
                    child: Container(
                      height: 481,
                      width: 342,
                      decoration: BoxDecoration(
                          color: const Color(0xFFff163e),
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "    Дорогой коллега,\n добро пожаловать на\n         Hansa - LAB.",
                            overflow: TextOverflow.fade,
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: const Color(0xFFffffff),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 10, top: 35, right: 10),
                            child: Text(
                              "Мы рады приветствовать тебя на портале Hansa LAB.Ты, наверное, подумал, что это очередной обучающий портал? Ты что, серьезно? Конечно, нет. Всё намного масштабнее.",
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFFffffff),
                              ),
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 10, top: 20, right: 10),
                            child: Text(
                              "Это и социальная сеть, и место выкладки видеоматериала, и площадка для премирования лучших менеджеров по продажам, и средство коммуникации, и обучающий портал. Hansa LAB постоянно делится только самым интересным материалом, на основании которого проводятся конкурсы, тесты, вебинары.",
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFFffffff),
                              ),
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 10, top: 20, right: 10),
                            child: Text(
                              "Данный проект призван объединить менеджеров по продажам КБТ со всей страны в одно единое целое ядро",
                              style: TextStyle(
                                fontSize: 11,
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
                    padding: const EdgeInsets.only(
                      top: 593,
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
                        height: 31,
                        width: 213,
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
                              fontSize: 12, color: const Color(0xFFffffff)),
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
