import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CompleteRegistr extends StatelessWidget {
  const CompleteRegistr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FlipCardController>(context);
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 278,
              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  width: 346,
                  height: 432,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:  [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: InkWell(
                              onTap: () => provider.toggleCard(),
                              child: const Icon(
                                Icons.close_rounded,
                                size: 24,
                                color: Color(0xff8c8c8b),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 85),
                        child: Text(
                          '        Спасибо\n за регистрацию',
                          style: GoogleFonts.montserrat(
                              fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 17),
                        child: Icon(
                          Icons.done,
                          color: Color(0xff25b049),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: Text(
                          '       Вам на почту \n отправлено письмо\n  с подтверждением\n      Ваших данных',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 37),
                        child: Container(
                          alignment: Alignment.center,
                          width: 319,
                          height: 47,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 4,
                                  blurRadius: 6,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: Color(0xff25b049),
                              borderRadius: BorderRadius.circular(23)),
                          child: Text(
                            'Войти в приложение',
                            style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffffffff)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 213, left: 130),
              child: Image.asset(
                'assets/Logo.png',
                height: 134,
                width: 134,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
