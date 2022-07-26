import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/drawer_widgets/text_field_for_personal.dart';

class PersonalniyDaniy extends StatefulWidget {
  const PersonalniyDaniy({Key? key}) : super(key: key);

  @override
  State<PersonalniyDaniy> createState() => _PersonalniyDaniyState();
}

class _PersonalniyDaniyState extends State<PersonalniyDaniy> {
  TextEditingController imyaController = TextEditingController(text: "Алексей");
  TextEditingController familyaController =
      TextEditingController(text: "Кузнецов");
  TextEditingController dataRojController =
      TextEditingController(text: "05.12.1985");
  TextEditingController emailController =
      TextEditingController(text: "Example@office.com");
  TextEditingController telefonController =
      TextEditingController(text: "+7 495 875 54 32");
  TextEditingController magazinController =
      TextEditingController(text: "М видео");
  TextEditingController doljnostController =
      TextEditingController(text: "Продавец");
  TextEditingController gorodController = TextEditingController(text: "Москва");
  TextEditingController adresController =
      TextEditingController(text: "Осенний бульвар, 23");

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            "assets/user_icons.png",
            height: 37,
            width: 37,
          ),
          const SizedBox(
            height: 11,
          ),
          Text(
            "Персональные данные",
            style: GoogleFonts.montserrat(
                fontSize: 13, color: const Color(0xFFffffff)),
          ),
          const SizedBox(
            height: 25,
          ),
          TextFieldForPersonal(text: "Имя", controller: imyaController),
          const SizedBox(
            height: 8,
          ),
          TextFieldForPersonal(text: "Фамилия", controller: familyaController),
          const SizedBox(
            height: 8,
          ),
          TextFieldForPersonal(
              text: "Дата рождения", controller: dataRojController),
          const SizedBox(
            height: 8,
          ),
          TextFieldForPersonal(text: "E-mail", controller: emailController),
          const SizedBox(
            height: 8,
          ),
          TextFieldForPersonal(text: "Телефон", controller: telefonController),
          const SizedBox(
            height: 8,
          ),
          TextFieldForPersonal(text: "Магазин", controller: magazinController),
          const SizedBox(
            height: 8,
          ),
          TextFieldForPersonal(
              text: "Должность", controller: doljnostController),
          const SizedBox(
            height: 8,
          ),
          TextFieldForPersonal(text: "Город", controller: gorodController),
          const SizedBox(
            height: 8,
          ),
          TextFieldForPersonal(text: "Адрес", controller: adresController),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
