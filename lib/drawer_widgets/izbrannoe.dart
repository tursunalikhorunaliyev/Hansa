import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Izbrannoe extends StatefulWidget {
  const Izbrannoe({Key? key}) : super(key: key);

  @override
  State<Izbrannoe> createState() => _IzbrannoeState();
}

class _IzbrannoeState extends State<Izbrannoe> {
  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);

    return Center(
      child: Container(
        height: isTablet ? 650 : 460,
        width: isTablet ? 500 : 323.6666666666667,
        color: const Color(0xFFffffff),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 17.66666666666667),
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0XFFff163e),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(21),
                            bottomRight: Radius.circular(21))),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 35.33333333333333,
                          right: 13.33333333333333,
                          top: 12.66666666666667,
                          bottom: 12.66666666666667),
                      child: Icon(
                        Icons.favorite,
                        size: 21.66666666666667,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("#",
                      style: GoogleFonts.montserrat(
                          color: const Color(0xFFff163e),
                          fontSize: isTablet ? 18  : 13.66666666666667)),
                  Text("Избранное",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF272624),
                          fontSize: isTablet ? 24 : 19.66666666666667)),
                  //#Избранное
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 300,
              child: ListView(
                padding: EdgeInsets.all(0),
                physics: BouncingScrollPhysics(),
                children: [
                  topContainer(isTablet),
                  topContainer(isTablet),
                  topContainer(isTablet),
                  topContainer(isTablet),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: isTablet  ? 30 : 30.66666666666667,
                  width: isTablet ?  170 : 157.6666666666667,
                  decoration: BoxDecoration(
                      color: const Color(0xFFe21a37),
                      borderRadius: BorderRadius.circular(15.33333333333333),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0XFFDBDBDB),
                          blurRadius: 5,
                          spreadRadius: 4,
                          offset: Offset(0, 6)
                        )
                      ]
                      ),
                  child: Text(
                    "Показать еще",
                    style: GoogleFonts.montserrat(
                      fontSize: 11.33333333333333,
                      color: const Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget topContainer(bool isTablet) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      children: [
        Row(
          children: [
            Image.asset(
              "assets/Rectangle 763 izbrannoe.png",
              height: isTablet ? 110 : 66.66666666666667,
              width: isTablet ? 150 : 101.6666666666667,
            ),
            const SizedBox(
              width: 11,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  """Обучающий материал \nдля сотрудников  \nЛеруа Мерлен""",
                  style: GoogleFonts.montserrat(
                      color: const Color(0xFF272624),
                      fontSize: isTablet ? 14  : 9.666666666666667,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                     SizedBox(
                      width: isTablet ? 140  : 90,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: isTablet ?  22 : 21,
                      width: isTablet ? 74  : 63,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.5),
                        color: const Color(0xFF313131),
                      ),
                      child: Text(
                        "Скачать",
                        style: GoogleFonts.montserrat(
                            color: const Color(0xFFFFFFFF), fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        const Divider(
          color: Color(0xFF8c8c8b),
          thickness: 1,
        )
      ],
    ),
  );
}
