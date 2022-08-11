import 'dart:developer';

import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/blocs/data_burn_text_changer_bloc.dart';
import 'package:hansa_app/blocs/hansa_country_api.dart';
import 'package:hansa_app/drawer_widgets/toggle_switcher.dart';
import 'package:hansa_app/extra/popup_full_registr_doljnost.dart';
import 'package:hansa_app/extra/popup_full_registr_gorod.dart';
import 'package:hansa_app/extra/popup_full_registr_nazvaniy_seti.dart';
import 'package:hansa_app/extra/text_field_for_full_reg.dart';
import 'package:hansa_app/providers/new_shop_provider.dart';
import 'package:hansa_app/providers/provider_for_flipping/flip_login_provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class FullRegistr extends StatefulWidget {
  const FullRegistr({Key? key}) : super(key: key);
  @override
  State<FullRegistr> createState() => _FullRegistrState();
}

class _FullRegistrState extends State<FullRegistr> {
  final dateRangeController = DateRangePickerController();
  final imyaTextEditingController = TextEditingController();
  final familiyaTextEditingController = TextEditingController();
  final emailTextFielController = TextEditingController();
  final phoneTextFieldController = TextEditingController();
  final adresTorgoviySetTextFielController = TextEditingController();
  final nazvaniyaTextFieldController = TextEditingController();
  final doljnostTextFieldController = TextEditingController();
  final gorodTextFieldController = TextEditingController();
  final firstToggle = TextEditingController(text: "0");
  final secondToggle = TextEditingController(text: "0");
  final thirdToggle = TextEditingController(text: "0");
  final fourthToggle = TextEditingController(text: "0");
  final dateBurnBloC = DateBornTextBloC();
  @override
  Widget build(BuildContext context) {
    final flipLoginProvider = Provider.of<FlipLoginProvider>(context);
    final newShop = Provider.of<NewShopProvider>(context);
    final isTablet = Provider.of<bool>(context);
    final providerFlip = Provider.of<Map<String, FlipCardController>>(context);
    log("SignUp build");
    final blocCity = HansaCountryBloC(1);
    blocCity.eventSink.add(CityEnum.city);
    return SingleChildScrollView(
      child: Center(
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: EdgeInsets.only(top: isTablet ? 446 : 274, bottom: 84),
                child: Container(
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
                                flipLoginProvider.changeIsClosed(false);
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
                      TextFieldForFullRegister(
                          textEditingController: imyaTextEditingController,
                          text: "Имя",
                          height: isTablet ? 45 : 38,
                          size: isTablet ? 13 : 10,
                          weight:
                              isTablet ? FontWeight.normal : FontWeight.normal),
                      const SizedBox(
                        height: 4,
                      ),
                      TextFieldForFullRegister(
                          textEditingController: familiyaTextEditingController,
                          text: "Фамилия",
                          height: isTablet ? 45 : 38,
                          size: isTablet ? 13 : 10,
                          weight:
                              isTablet  ? FontWeight.normal :  FontWeight.normal),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFieldForFullRegister(
                          textEditingController: emailTextFielController,
                          text: "Email",
                          height: isTablet ? 45 : 38,
                          size: isTablet ? 13 : 10,
                          weight:
                              isTablet ? FontWeight.normal : FontWeight.normal),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(54),
                          child: Container(
                            color: Colors.white,
                            height: 38,
                            child: InternationalPhoneNumberInput(
                              onInputChanged: (value) {
                                phoneTextFieldController.text =
                                    value.phoneNumber!;
                              },
                              inputDecoration: inputDecoration(isTablet),
                              keyboardType: TextInputType.phone,
                              selectorTextStyle: style(FontWeight.w500, isTablet),
                              textStyle: style(FontWeight.w500, isTablet),
                              selectorConfig: SelectorConfig(
                                  leadingPadding: 0,
                                  
                                  useEmoji: false,
                                  showFlags: false,
                                  setSelectorButtonAsPrefixIcon: true,
                                  selectorType:
                                      PhoneInputSelectorType.BOTTOM_SHEET),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      InkWell(
                        onTap: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (context) {
                                return Container(
                                    width: 360,
                                    height: 400,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: SfDateRangePicker(
                                      controller: dateRangeController,
                                      selectionColor: Colors.pink[600],
                                      todayHighlightColor: Colors.pink[600],
                                      onSelectionChanged: (a) {
                                        String day = dateRangeController
                                                    .selectedDate!.day
                                                    .toString()
                                                    .length ==
                                                1
                                            ? "0${dateRangeController.selectedDate!.day}"
                                            : dateRangeController
                                                .selectedDate!.day
                                                .toString();
                                        String month = dateRangeController
                                                    .selectedDate!.month
                                                    .toString()
                                                    .length ==
                                                1
                                            ? "0${dateRangeController.selectedDate!.month}"
                                            : dateRangeController
                                                .selectedDate!.month
                                                .toString();
                                        String year = dateRangeController
                                            .selectedDate!.year
                                            .toString();
                                        dateBurnBloC.streamSink.add(
                                            day + "." + month + "." + year);
                                        Navigator.pop(context);
                                      },
                                    ));
                              });
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 14),
                            child: StreamBuilder<String>(
                                initialData: "Дата рождения",
                                stream: dateBurnBloC.stream,
                                builder: (context, snapshot) {
                                  return Text(
                                    snapshot.data!,
                                    style: snapshot.data == "Дата рождения"
                                        ? GoogleFonts.montserrat(
                                    fontSize: isTablet ? 13 : 10,
                                    color: const Color(0xFF444444))
                                        : GoogleFonts.montserrat(
                                            fontSize: isTablet ? 13 : 10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                  );
                                }),
                          ),
                          width: isTablet ? 538 : 325,
                          height: isTablet ? 43 : 38,
                          decoration: BoxDecoration(
                            color: const Color(0xFFffffff),
                            borderRadius: BorderRadius.circular(54),
                            border: Border.all(width: 0.1),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Provider(
                          create: (context) => nazvaniyaTextFieldController,
                          child: PopupFullRegistrNazvaniySeti()),
                      const SizedBox(
                        height: 4,
                      ),
                      Provider(
                          create: (context) => doljnostTextFieldController,
                          child: PopupFullRegistrDoljnost()),
                      const SizedBox(
                        height: 4,
                      ),
                      Provider(
                          create: (context) => gorodTextFieldController,
                          child: PopupFullRegistrGorod()),
                      const SizedBox(
                        height: 4,
                      ),
                      TextFieldForFullRegister(
                          textEditingController:
                              adresTorgoviySetTextFielController,
                          text: "Адрес торговой сети",
                          height: isTablet ? 45 : 38,
                          size: isTablet ? 13 : 10,
                          weight:
                              isTablet  ? FontWeight.normal :  FontWeight.normal),
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
                                Provider(
                                  create: (context) => firstToggle,
                                  child: ToggleSwitch(
                                    handlerWidth: 40,
                                    handlerHeight: 12,
                                    tickerSize: 21,
                                    colorCircle: Colors.green[600],
                                    colorContainer: Colors.grey[300],
                                    onButton: () {
                                      print("Не выходить из приложения");
                                    },
                                  ),
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
                                Provider(
                                  create: (context) => secondToggle,
                                  child: ToggleSwitch(
                                    handlerWidth: 40,
                                    handlerHeight: 12,
                                    tickerSize: 21,
                                    colorCircle: Colors.green[600],
                                    colorContainer: Colors.grey[300],
                                    onButton: () {
                                      print("Согласен на СМС и Email рассылку");
                                    },
                                  ),
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
                                Provider(
                                  create: (context) => thirdToggle,
                                  child: ToggleSwitch(
                                    handlerWidth: 40,
                                    handlerHeight: 12,
                                    tickerSize: 21,
                                    colorCircle: Colors.green[600],
                                    colorContainer: Colors.grey[300],
                                    onButton: () {
                                      print("Подтверждаю подлиность данных");
                                    },
                                  ),
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
                                Provider(
                                  create: (context) => fourthToggle,
                                  child: ToggleSwitch(
                                    handlerWidth: 40,
                                    handlerHeight: 12,
                                    tickerSize: 21,
                                    colorCircle: Colors.green[600],
                                    colorContainer: Colors.grey[300],
                                    onButton: () {
                                      print(
                                          "Соглашаюсь на обработку персональных данных");
                                    },
                                  ),
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
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              providerFlip['signin']!.toggleCard();
                              List<String> date = dateRangeController
                                  .selectedDate!
                                  .toIso8601String()
                                  .split("T")[0]
                                  .split("-");
                              toSignUp(
                                firstname: imyaTextEditingController.text,
                                lastname: familiyaTextEditingController.text,
                                email: emailTextFielController.text,
                                phone: phoneTextFieldController.text,
                                bornedAt: "${date[2]}.${date[1]}.${date[0]}",
                                nazvaniya: nazvaniyaTextFieldController.text,
                                dolj: doljnostTextFieldController.text,
                                gorod: gorodTextFieldController.text,
                                shopadress:
                                    adresTorgoviySetTextFielController.text,
                                shopnet: newShop.getNewShop.toString(),
                                smsemail: secondToggle.text,
                                lichnostdannix: thirdToggle.text,
                                personalnixdannix: fourthToggle.text,
                              );
                            },
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
                                    offset: const Offset(0, 15),
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
                          )),
                      const SizedBox(
                        height: 60,
                      )
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
              Positioned(
                bottom: 10,
                left: 40,
                right: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "По всем вопросам пришите на",
                      style: TextStyle(fontSize: 11, color: Color(0xFF989a9d)),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Support@hansa-lab.ru",
                      style: GoogleFonts.montserrat(
                          fontSize: 11,
                          color: const Color(0xFF989a9d),
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
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

  toSignUp(
      {required String lastname,
      required String firstname,
      required String email,
      required String phone,
      required String bornedAt,
      required String nazvaniya,
      required String dolj,
      required String gorod,
      required String shopadress,
      required String shopnet,
      required String smsemail,
      required String lichnostdannix,
      required String personalnixdannix}) {
    log(lastname.toString());
    log(firstname.toString());
    log(email.toString());
    log(phone.toString());
    log(bornedAt);
    log(nazvaniya.toString());
    log(dolj.toString());
    log(shopnet);
    log(gorod.toString());
    log(shopadress.toString());
    log(firstToggle.text);
    log(smsemail);
    log(lichnostdannix);
    log(personalnixdannix);
    /*BlocSignUp().signUp(
      lastname,
      firstname,
      email,
      bornedAt,
      dolj,
      nazvaniya,
      shopnet,
      shopadress,
      phone,
      "1",
      gorod,
      secondToggle.text,
      thirdToggle.text,
      fourthToggle.text,
    );*/
  }

  InputDecoration inputDecoration(bool isTablet) {
    return InputDecoration(
      hintText: "(223) 232-13-12",
      isDense: true,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: .9, color: Colors.grey),
        borderRadius: BorderRadius.circular(54),
      ),
      focusedErrorBorder: outlineInputBorder(.1),
      enabledBorder: outlineInputBorder(.2),
      errorBorder: outlineInputBorder(.1),
      contentPadding: const EdgeInsets.symmetric(vertical: 2),
      hintStyle: style(FontWeight.normal, isTablet),
    );
  }

  OutlineInputBorder outlineInputBorder(double width) {
    return OutlineInputBorder(
        borderSide: BorderSide(width: width),
        borderRadius: BorderRadius.circular(54));
  }

  TextStyle style(FontWeight fontWeight, bool isTablet) {
    return GoogleFonts.montserrat(
      fontWeight: fontWeight,
      fontSize: isTablet ? 13 : 10,
      color: const Color(0xFF444444),
    );
  }
}
