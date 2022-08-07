import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/drawer_widgets/text_icon.dart';
import 'package:hansa_app/drawer_widgets/toggle_switcher.dart';
import 'package:provider/provider.dart';

class NastroykaWidget extends StatelessWidget {
  const NastroykaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 26),
          child: TextIcon(
            text: "Настройки",
            iconUrl: "assets/icon.png",
            colorIcon: const Color(0xFFaaaaaa),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Divider(
          color: Color(0xFF444444),
          thickness: 2,
          indent: 26,
          endIndent: 26,
        ),
        const SizedBox(
          height: 43,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 37, right: 23),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Включить пуш уведомления",
                  style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: const Color(0xFFffffff),
                      fontWeight: FontWeight.w500)),
              MultiProvider(
                providers: [
                  Provider(
                    create: (context) => String,
                  ),
                  Provider(
                    create: (context) => TextEditingController(),
                  )
                ],
                child: ToggleSwitch(
                  colorCircle: const Color(0xFF25b049),
                  handlerWidth: 40,
                  handlerHeight: 12,
                  tickerSize: 21,
                  boxShadow: false,
                  colorContainer: const Color(0xFFdddddd),
                  onButton: () {},
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 38,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 37, right: 23),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Подписка на рассылку",
                  style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: const Color(0xFFffffff),
                      fontWeight: FontWeight.w500)),
              MultiProvider(
                providers: [
                  Provider(
                    create: (context) => String,
                  ),
                  Provider(
                    create: (context) => TextEditingController(),
                  )
                ],
                child: ToggleSwitch(
                  colorCircle: const Color(0xFF25b049),
                  handlerWidth: 40,
                  handlerHeight: 12,
                  tickerSize: 21,
                  boxShadow: false,
                  colorContainer: const Color(0xFFdddddd),
                  onButton: () {},
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 38,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 37, right: 23),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Оставаться в трее ",
                  style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: const Color(0xFFffffff),
                      fontWeight: FontWeight.w500)),
              MultiProvider(
                providers: [
                  Provider(
                    create: (context) => String,
                  ),
                  Provider(
                    create: (context) => TextEditingController(),
                  )
                ],
                child: ToggleSwitch(
                  colorCircle: const Color(0xFF25b049),
                  handlerWidth: 40,
                  handlerHeight: 12,
                  tickerSize: 21,
                  boxShadow: false,
                  colorContainer: const Color(0xFFdddddd),
                  onButton: () {},
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 186,
        ),
        const Divider(
          color: Color(0xFF444444),
          thickness: 2,
          indent: 26,
          endIndent: 26,
        ),
      ],
    );
  }
}
