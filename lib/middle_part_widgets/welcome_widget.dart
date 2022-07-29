import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/extra/event_cards.dart';
import 'package:provider/provider.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: isTablet ? 20 : 9),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: isTablet ? 120 : 70,
                    height: isTablet ? 70 : 42,
                    decoration: BoxDecoration(
                        color: const Color(0XFFff163e),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(isTablet ? 40 : 21),
                            bottomRight: Radius.circular(isTablet ? 40 : 21))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Image.asset(
                        'assets/Lab.png',
                        height: isTablet ? 50 : 12,
                        width: isTablet ? 70 : 42,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      '#',
                      style: GoogleFonts.montserrat(
                          fontSize: isTablet ? 25 : 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xffff163e)),
                    ),
                  ),
                  Text(
                    'Добро пожаловать',
                    style: GoogleFonts.montserrat(
                        fontSize: isTablet ? 30 : 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff272624)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: isTablet ? 877 : 566,
              width: isTablet ? 800 : 330,
              child: isTablet
                  ? SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/dobriy.png",
                              width: 900,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Column(
                            children: List.generate(
                                20,
                                (index) => Row(
                                      children: const [
                                        Padding(
                                            padding: EdgeInsets.only(top: 5.0),
                                            child: EventCards(
                                              buttonColor: Color(0xffff163e),
                                              buttonText: 'Смотреть',
                                              isDate: true,
                                              month: "июля",
                                              day: "8",
                                              isFavourite: false,
                                              title:
                                                  '''Минутка ностальгии: смотрим отчеты с тренинговв Екатеринбурге и Перми!''',
                                              url: 'assets/A.png',
                                            )),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 5.0),
                                            child: EventCards(
                                              buttonColor: Color(0xffff163e),
                                              buttonText: 'Смотреть',
                                              isDate: true,
                                              month: "июля",
                                              day: "8",
                                              isFavourite: false,
                                              title:
                                                  '''Минутка ностальгии: смотрим отчеты с тренинговв Екатеринбурге и Перми!''',
                                              url: 'assets/A.png',
                                            )),
                                      ],
                                    )),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: List.generate(
                            20,
                            (index) => const Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: EventCards(
                                  buttonColor: Color(0xffff163e),
                                  buttonText: 'Смотреть',
                                  isDate: true,
                                  month: "июля",
                                  isFavourite: false,
                                  day: "8",
                                  title:
                                      '''Минутка ностальгии: смотрим отчеты с тренинговв Екатеринбурге и Перми!''',
                                  url: 'assets/A.png',
                                ))),
                      ),
                    ),
            )
          ],
        ),
      ],
    );
  }
}
