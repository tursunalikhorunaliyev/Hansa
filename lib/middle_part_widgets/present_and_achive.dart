import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/extra/archive_card.dart';
import 'package:sticky_headers/sticky_headers.dart';

class PresentArchive extends StatefulWidget {
  const PresentArchive({Key? key}) : super(key: key);

  @override
  State<PresentArchive> createState() => _PresentArchiveState();
}

class _PresentArchiveState extends State<PresentArchive> {
  @override
  Widget build(BuildContext context) {
    List<Widget> data() {
      List<Widget> list = [];
      for (int i = 0; i < 5; i++) {
        list.add(
          ArchiveCard(
            buttonColor: const Color(0xffff163e),
            topButtonText: 'Скачать',
            bottomButtonText: 'Читать',
            skachat: Container(
              alignment: Alignment.center,
              width: 94,
              height: 25,
              decoration: BoxDecoration(
                  color: const Color(0xff31353b),
                  borderRadius: BorderRadius.circular(13)),
              child: Text(
                'skachat',
                style: GoogleFonts.montserrat(
                    fontSize: 10,
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w500),
              ),
            ),
            title:
                'Функция SoftSteam',
            url:
                'https://thumbs.dreamstime.com/b/happy-family-having-roast-chicken-dinner-table-18044089.jpg',
          ),
        ); //add any Widget in place of Text("Index $i")
      }
      return list; // all widget added now retrun the list here
    }

    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
            children: List.generate(
          1,
          (index) {
            return Column(
              children: [
                StickyHeader(
                    header: Container(
                      color: const Color(0xffeaeaea),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 9, bottom: 5),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 70,
                              height: 42,
                              decoration: const BoxDecoration(
                                  color: Color(0XFFff163e),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(21),
                                      bottomRight: Radius.circular(21))),
                              child: Image.asset(
                                'assets/Презентации.png',
                                height: 30,
                                width: 30,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                '#',
                                style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xffff163e)),
                              ),
                            ),
                            Text(
                              'Презентации ',
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff272624)),
                            )
                          ],
                        ),
                      ),
                    ),
                    content: Column(
                      children: [
                        Row(),
                        Column(
                          children: data(),
                        )
                      ],
                    )),
                StickyHeader(
                    header: Container(
                      color: const Color(0xffeaeaea),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 9, bottom: 5),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 70,
                              height: 42,
                              decoration: const BoxDecoration(
                                  color: Color(0XFFff163e),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(21),
                                      bottomRight: Radius.circular(21))),
                              child: Image.asset(
                                'assets/Архив.png',
                                height: 30,
                                width: 30,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                '#',
                                style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xffff163e)),
                              ),
                            ),
                            Text(
                              'Архив',
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff272624)),
                            )
                          ],
                        ),
                      ),
                    ),
                    content: Column(
                      children: [
                        Row(),
                        Column(
                          children: data(),
                        )
                      ],
                    )),
              ],
            );
          },
        )),
      ),
    );
  }
}
