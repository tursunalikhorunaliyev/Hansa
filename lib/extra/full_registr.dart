import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/drawer_widgets/toggle_switcher.dart';
import 'package:provider/provider.dart';

class FullRegistr extends StatefulWidget {
  const FullRegistr({Key? key}) : super(key: key);

  @override
  State<FullRegistr> createState() => _FullRegistrState();
}

class _FullRegistrState extends State<FullRegistr> {
  //list item changed
  final List<String> items = [
    "Название сети",
    "Должность",
    "Город*",
  ];
  //////lkkbhbugigkyujvh
  ///new thins
  String selectedValue = "Название сети";
  String selectedValue2 = "Должность";
  String selectedValue3 = "Город*";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FlipCardController>(context);
    final isTablet = Provider.of<bool>(context);
    return Padding(
      padding: EdgeInsets.only(top: 230),
      child: SingleChildScrollView(
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 274, bottom: 84),
                child: Container(
                  height: isTablet ? 950 : 890,
                  width: isTablet ? 516 : 346,
                  decoration: BoxDecoration(
                      color: const Color(0xFFf2f2f2),
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(
                              Icons.close_rounded,
                              size: 30,
                              color: Color(0xFF8c8c8b),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 82),
                        child: Text(
                          "Регистрация",
                          style: GoogleFonts.montserrat(
                              fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      textField("Имя*", isTablet ? 45 : 38, isTablet ? 13 : 10,
                          isTablet ? FontWeight.w600 : FontWeight.normal),
                      const SizedBox(
                        height: 4,
                      ),
                      textField(
                          "Фамилия*",
                          isTablet ? 45 : 38,
                          isTablet ? 13 : 10,
                          isTablet ? FontWeight.w600 : FontWeight.normal),
                      const SizedBox(
                        height: 5,
                      ),
                      textField(
                          "Email*",
                          isTablet ? 45 : 38,
                          isTablet ? 13 : 10,
                          isTablet ? FontWeight.w600 : FontWeight.normal),
                      const SizedBox(
                        height: 4,
                      ),
                      textField(
                          "Контактный тефон*",
                          isTablet ? 45 : 38,
                          isTablet ? 15 : 10,
                          isTablet ? FontWeight.w600 : FontWeight.normal),
                      const SizedBox(
                        height: 4,
                      ),
                      textField(
                          "Дата рождения*",
                          isTablet ? 45 : 38,
                          isTablet ? 15 : 10,
                          isTablet ? FontWeight.w600 : FontWeight.normal),
                      const SizedBox(
                        height: 4,
                      ),
                      dropDown(
                          "Название сети",
                          selectedValue,
                          isTablet ? 495 : 325,
                          isTablet ? 15 : 10,
                          isTablet ? FontWeight.w600 : FontWeight.normal),
                      const SizedBox(
                        height: 4,
                      ),
                      dropDown(
                          "Должность",
                          selectedValue2,
                          isTablet ? 495 : 325,
                          isTablet ? 15 : 10,
                          isTablet ? FontWeight.w600 : FontWeight.normal),
                      const SizedBox(
                        height: 4,
                      ),
                      dropDown(
                          "Город*",
                          selectedValue3,
                          isTablet ? 495 : 325,
                          isTablet ? 15 : 10,
                          isTablet ? FontWeight.w600 : FontWeight.normal),
                      const SizedBox(
                        height: 4,
                      ),
                      textField(
                          "Адрес торговой сети",
                          isTablet ? 45 : 38,
                          isTablet ? 13 : 10,
                          isTablet ? FontWeight.w600 : FontWeight.normal),
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        "assets/Layer 972.png",
                        height: 64,
                        width: 234,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textSwitch("Не выходить из приложения"),
                                ToggleSwitch(
                                  handlerWidth: 40,
                                  handlerHeight: 12,
                                  tickerSize: 21,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 17,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textSwitch("Согласен на СМС и Email рассылку"),
                                ToggleSwitch(
                                  handlerWidth: 40,
                                  handlerHeight: 12,
                                  tickerSize: 21,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 17,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textSwitch("Подтверждаю подлиность данных"),
                                ToggleSwitch(
                                  handlerWidth: 40,
                                  handlerHeight: 12,
                                  tickerSize: 21,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 17,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textSwitch("""Соглашаюсь на обработку 
             персональных данных"""),
                                const SizedBox(
                                  width: 75,
                                ),
                                ToggleSwitch(
                                  handlerWidth: 40,
                                  handlerHeight: 12,
                                  tickerSize: 21,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 11,
                          right: 9,
                          top: 25,
                        ),
                        child: GestureDetector(
                          onTap: () => provider.toggleCard(),
                          child: Container(
                            alignment: Alignment.center,
                            height: 46,
                            width: 325,
                            decoration: BoxDecoration(
                              color: const Color(0xFF25b049),
                              borderRadius: BorderRadius.circular(70),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Text(
                              "Зарегистрироваться",
                              style: GoogleFonts.montserrat(
                                  fontSize: 12, color: const Color(0xFFffffff)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: isTablet ? 186 : 215,
                left: isTablet ? 157 : 107,
                child: isTablet
                    ? Image.asset("assets/tabletTumLogo.png")
                    : Image.asset(
                        "assets/Logo.png",
                        height: 133,
                        width: 133,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(String text, double height, double size, FontWeight weight) {
    return Padding(
      padding: const EdgeInsets.only(left: 11, right: 9),
      child: SizedBox(
        height: height,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFffffff),
            borderRadius: BorderRadius.circular(54),
          ),
          child: TextField(
            cursorHeight: 20,
            style: GoogleFonts.montserrat(fontSize: 14),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 0.9, color: Colors.grey),
                borderRadius: BorderRadius.circular(54),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0.1),
                  borderRadius: BorderRadius.circular(54)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 2, horizontal: 13),
              hintText: text,
              hintStyle: GoogleFonts.montserrat(
                  fontWeight: weight,
                  fontSize: size,
                  color: const Color(0xFF444444)),
            ),
          ),
        ),
      ),
    );
  }

  Widget dropDown(String text, String choiseValue, double width, double size,
      FontWeight weight) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 11,
        right: 9,
      ),
      child: Container(
        height: 38,
        width: width,
        decoration: BoxDecoration(
          color: const Color(0xFFffffff),
          borderRadius: BorderRadius.circular(54),
          border: Border.all(width: 0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 16, left: 17),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              dropdownWidth: 325,
              dropdownDecoration: const BoxDecoration(
                  color: Color(0xFFf8f8f8),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              buttonDecoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(54)),
              hint: Text(text,
                  style: GoogleFonts.montserrat(
                      fontSize: 10, color: const Color(0xFF444444))),
              items: items
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: GoogleFonts.montserrat(
                              fontWeight: weight,
                              fontSize: size,
                              color: const Color(0xFF444444)),
                        ),
                      ))
                  .toList(),
              value: choiseValue,
              onChanged: (value) {
                setState(() {
                  choiseValue = value as String;
                });
              },
              buttonHeight: 40,
              buttonWidth: 140,
              itemHeight: 40,
            ),
          ),
        ),
      ),
    );
  }

  Widget textSwitch(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
          fontSize: 11,
          color: const Color(0xFFa1b7c2),
          fontWeight: FontWeight.w500),
    );
  }
}
