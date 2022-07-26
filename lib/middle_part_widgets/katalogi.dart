import 'package:flutter/material.dart';
import 'package:hansa_app/extra/custom_katalog_item_double.dart';
import 'package:hansa_app/extra/custom_title.dart';

class Katalogi extends StatefulWidget {
  const Katalogi({Key? key}) : super(key: key);

  @override
  State<Katalogi> createState() => _KatalogiState();
}

class _KatalogiState extends State<Katalogi> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const CustomTitle(
            imagePath: "assets/katalogi_title.png",
            title: "Каталоги",
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: List.generate(
                  15,
                  (index) => const CustomKatalogItemDouble(
                    imageUrl: "assets/backgr.png",
                    backgroundColor: Color(0xff000004),
                    buttonTextColor: Color(0xffffffff),
                    buttonColor: Color(0xffff163e),
                    titleColor: Color(0xffffffff),
                    title: "Духовые шкафы",
                    stbuttonText: "Скачать",
                    ndbuttonText: "Читать",
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
