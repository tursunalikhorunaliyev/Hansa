import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/blocs/bloc_flip_login.dart';
import 'package:hansa_app/drawer_widgets/toggle_switcher.dart';
import 'package:hansa_app/extra/text_field_for_full_reg.dart';
import 'package:provider/provider.dart';

class FullRegistr extends StatefulWidget {
  const FullRegistr({Key? key}) : super(key: key);

  @override
  State<FullRegistr> createState() => _FullRegistrState();
}

class _FullRegistrState extends State<FullRegistr> {
  final List<String> items = [
    "Название сети",
    "Должность",
    "Город*",
  ];
  String selectedValue = "Название сети";
  String selectedValue2 = "Должность";
  String selectedValue3 = "Город*";

  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    final providerFlip = Provider.of<Map<String, FlipCardController>>(context);
    final providerFlipLogin = Provider.of<BlocFlipLogin>(context);

    return SingleChildScrollView(
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.only(top: isTablet ? 446 : 274, bottom: 84),
              child: Container(
                height: isTablet ? 1020 : 890,
                width: isTablet ? 556 : 346,
                decoration: BoxDecoration(
                    color: const Color(0xFFf2f2f2),
                    borderRadius: BorderRadius.circular(isTablet ? 16 : 5)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              providerFlipLogin.sink.add(false);
                              providerFlip['login']!.toggleCard();
                            },
                            child: const Icon(
                              Icons.close_rounded,
                              size: 30,
                              color: Color(0xFF8c8c8b),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: isTablet ? 75 : 82),
                      child: Text(
                        "Регистрация",
                        style: GoogleFonts.montserrat(
                            fontSize: isTablet ? 28 : 24,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFieldForFullRegister(text:  "Имя", height: isTablet ? 45 : 38, size: isTablet ? 13 : 10,
                     weight:   isTablet ? FontWeight.w600 : FontWeight.normal),
                    const SizedBox(
                      height: 4,
                    ),
                    TextFieldForFullRegister(
                       text: "Фамилия",
                     height:   isTablet ? 45 : 38,
                      size:  isTablet ? 13 : 10,
                       weight:  isTablet ? FontWeight.w600 : FontWeight.normal),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFieldForFullRegister(text: "Email", height: isTablet ? 45 : 38, size: isTablet ? 13 : 10,
                    weight:    isTablet ? FontWeight.w600 : FontWeight.normal),
                    const SizedBox(
                      height: 4,
                    ),
                    TextFieldForFullRegister(
                     text:   "Контактный тефон",
                     height:   isTablet ? 45 : 38,
                      size:  isTablet ? 15 : 10,
                      weight:  isTablet ? FontWeight.w600 : FontWeight.normal),
                    const SizedBox(
                      height: 4,
                    ),
                    TextFieldForFullRegister(
                       text: "Дата рождения",
                      height:  isTablet ? 45 : 38,
                       size: isTablet ? 15 : 10,
                      weight:   isTablet ? FontWeight.w600 : FontWeight.normal),
                    const SizedBox(
                      height: 4,
                    ),
                    dropDown(
                        "Название сети",
                        selectedValue,
                        isTablet ? 538 : 325,
                        isTablet ? 15 : 10,
                        isTablet ? 43 : 38,
                        isTablet ? FontWeight.w600 : FontWeight.normal),
                    const SizedBox(
                      height: 4,
                    ),
                    dropDown(
                        "Должность",
                        selectedValue2,
                        isTablet ? 538 : 325,
                        isTablet ? 15 : 10,
                        isTablet ? 43 : 38,
                        isTablet ? FontWeight.w600 : FontWeight.normal),
                    const SizedBox(
                      height: 4,
                    ),
                    dropDown(
                      "Город*",
                      selectedValue3,
                      isTablet ? 538 : 325,
                      isTablet ? 15 : 10,
                      isTablet ? 43 : 38,
                      isTablet ? FontWeight.w600 : FontWeight.normal,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextFieldForFullRegister(
                      text:  "Адрес торговой сети",
                     height:   isTablet ? 45 : 38,
                      size:  isTablet ? 13 : 10,
                    weight:    isTablet ? FontWeight.w600 : FontWeight.normal),
                    const SizedBox(
                      height: 10,
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
                              textSwitch("Не выходить из приложения",
                                  isTablet ? 16 : 11),
                              ToggleSwitch(
                                handlerWidth: 40,
                                handlerHeight: 12,
                                tickerSize: 21,
                                colorCircle: Colors.green[600],
                                colorContainer: Colors.grey[300],
                                onButton: (){
                                  print("Не выходить из приложения");
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              textSwitch("Согласен на СМС и Email рассылку",
                                  isTablet ? 16 : 11),
                              ToggleSwitch(
                                handlerWidth: 40,
                                handlerHeight: 12,
                                tickerSize: 21,
                                colorCircle: Colors.green[600],
                                colorContainer: Colors.grey[300],
                                onButton: (){
                                  print("Согласен на СМС и Email рассылку");
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              textSwitch("Подтверждаю подлиность данных",
                                  isTablet ? 16 : 11),
                              ToggleSwitch(
                                handlerWidth: 40,
                                handlerHeight: 12,
                                tickerSize: 21,
                                colorCircle: Colors.green[600],
                                colorContainer: Colors.grey[300],
                                onButton: (){
                                  print("Подтверждаю подлиность данных");
                                },
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
персональных данных""", isTablet ? 16 : 11),
                              const SizedBox(
                                width: 75,
                              ),
                              ToggleSwitch(
                                handlerWidth: 40,
                                handlerHeight: 12,
                                tickerSize: 21,
                                colorCircle: Colors.green[600],
                                colorContainer: Colors.grey[300],
                                onButton: (){
                                  print("Соглашаюсь на обработку персональных данных");
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 11,
                        right: 9,
                        top: isTablet ? 30 : 25,
                      ),
                      child: GestureDetector(
                        onTap: () => providerFlip['signin']!.toggleCard(),
                        child: Container(
                          alignment: Alignment.center,
                          height: isTablet ? 60 : 46,
                          width: isTablet ? 525 : 325,
                          decoration: BoxDecoration(
                            color: const Color(0xFF25b049),
                            borderRadius: BorderRadius.circular(70),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 15), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Text(
                            "Зарегистрироваться",
                            style: GoogleFonts.montserrat(
                                fontSize: isTablet ? 18 : 12,
                                color: const Color(0xFFffffff)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: isTablet ? 355 : 215,
              left: isTablet ? 177 : 107,
              child: isTablet
                  ? Image.asset("assets/tabletTumLogo.png")
                  : Image.asset(
                      "assets/Logo.png",
                      height: 133,
                      width: 133,
                    ),
            ),
            Padding(
               padding:const EdgeInsets.only(
                 top: 1180, left: 95
               ),
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                 children:  [
                const   Text(
                     "По всем вопросам пришите на",
                     style: TextStyle(fontSize: 11, color: Color(0xFF989a9d)),
                   ),
                const   SizedBox(
                    height: 6,
                   ),
                   Text(
                     "Support@hansa-lab.ru",
                     style: GoogleFonts.montserrat(fontSize: 11, color: const Color(0xFF989a9d), fontWeight: FontWeight.w700),
                   ),
                 ],
               ),
             ),
          ],
        ),
      ),
    );
  }

  
  Widget dropDown(String text, String choiseValue, double width, double size,
      double height, FontWeight weight) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 11,
        right: 9,
      ),
      child: Container(
        height: height,
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

  Widget textSwitch(String text, double size) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
          fontSize: size,
          color: const Color(0xFFa1b7c2),
          fontWeight: FontWeight.w500),
    );
  }
}
