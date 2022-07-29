import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/drawer_widgets/referal_silka.dart';
import 'package:hansa_app/drawer_widgets/text_field_for_personal.dart';
import 'package:provider/provider.dart';

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
    final isTablet = Provider.of<bool>(context);
    return Center(
      child: Column(
        children: [
          Image.asset(
            "assets/user_icons.png",
            height: isTablet ? 50 : 37,
            width: isTablet ? 50 : 37,
          ),
          const SizedBox(
            height: 11,
          ),
          Text(
            "Персональные данные",
            style: GoogleFonts.montserrat(
                fontSize: isTablet ? 16 : 13, color: const Color(0xFFffffff)),
          ),
          SizedBox(
            height: isTablet ? 40 : 25,
          ),
          TextFieldForPersonal(text: "Имя", controller: imyaController),
          SizedBox(
            height: isTablet ? 15 : 8,
          ),
          TextFieldForPersonal(text: "Фамилия", controller: familyaController),
          SizedBox(
            height: isTablet ? 15 : 8,
          ),
          TextFieldForPersonal(
              text: "Дата рождения", controller: dataRojController),
          SizedBox(
            height: isTablet ? 15 : 8,
          ),
          TextFieldForPersonal(text: "E-mail", controller: emailController),
          SizedBox(
            height: isTablet ? 15 : 8,
          ),
          TextFieldForPersonal(text: "Телефон", controller: telefonController),
          SizedBox(
            height: isTablet ? 15 : 8,
          ),
          TextFieldForPersonal(
            text: "Магазин",
            controller: magazinController,
          ),
          SizedBox(
            height: isTablet ? 15 : 8,
          ),
          TextFieldForPersonal(
              text: "Должность", controller: doljnostController),
          SizedBox(
            height: isTablet ? 15 : 8,
          ),
          TextFieldForPersonal(text: "Город", controller: gorodController),
          SizedBox(
            height: isTablet ? 15 : 8,
          ),
          TextFieldForPersonal(text: "Адрес", controller: adresController),
          SizedBox(
            height: isTablet ? 50 : 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 10),
            child: const ReferalSilka(),
          ),
        ],
      ),
    );
  }
}
