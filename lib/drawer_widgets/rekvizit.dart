import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/drawer_widgets/text_field_for_rekvizit.dart';

class Rekvizit extends StatelessWidget {
  const Rekvizit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 23,
          ),
          Image.asset(
            "assets/free-icon-personal-data-3740813.png",
            height: 37,
            width: 37,
          ),
          const SizedBox(
            height: 11,
          ),
          Text(
            "Реквизиты",
            style: GoogleFonts.montserrat(
                fontSize: 13, color: const Color(0xFFffffff)),
          ),
          const SizedBox(
            height: 25,
          ),
          TextFieldForRekvizit(
            hintText: "Серия и номер паспорта",
          ),
          const SizedBox(
            height: 8,
          ),
          TextFieldForRekvizit(
            hintText: "Кем выдан",
          ),
          const SizedBox(
            height: 8,
          ),
          TextFieldForRekvizit(
            hintText: "Дата выдачи",
          ),
          const SizedBox(
            height: 8,
          ),
          TextFieldForRekvizit(
            hintText: "Адрес регистрации",
          ),
          const SizedBox(
            height: 8,
          ),
          TextFieldForRekvizit(
            hintText: "ИНН",
          ),
          const SizedBox(
            height: 8,
          ),
          TextFieldForRekvizit(
            hintText: "р/с карты",
          ),
          const SizedBox(
            height: 8,
          ),
          TextFieldForRekvizit(
            hintText: "БИК банка",
          ),
          const SizedBox(
            height: 8,
          ),
          TextFieldForRekvizit(
            hintText: "кр/с банка",
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
