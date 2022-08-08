import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Izbrannoe extends StatefulWidget {
  const Izbrannoe({Key? key}) : super(key: key);

  @override
  State<Izbrannoe> createState() => _IzbrannoeState();
}

class _IzbrannoeState extends State<Izbrannoe> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 485.6666666666667,
        width: 323.6666666666667,
        color: const Color(0xFFffffff),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                          fontSize: 13.66666666666667)),
                  Text("Избранное",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF272624),
                          fontSize: 19.66666666666667)),
                  //#Избранное
                ],
              ),
            ),
            const SizedBox(
              height: 15.66666666666667,
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  topContainer(),
                  topContainer(),
                  topContainer(),
                  topContainer(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 84.33333333333333,
                  right: 84.33333333333333,
                  top: 20,
                  bottom: 20),
              child: Container(
                alignment: Alignment.center,
                height: 30.66666666666667,
                width: 157.6666666666667,
                decoration: BoxDecoration(
                    color: const Color(0xFFe21a37),
                    borderRadius: BorderRadius.circular(15.33333333333333)),
                child: Text(
                  "Показать еще",
                  style: GoogleFonts.montserrat(
                    fontSize: 11.33333333333333,
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget topContainer() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 28.33333333333333),
    child: Column(
      children: [
        Row(
          children: [
            Image.asset(
              "assets/Rectangle 763 izbrannoe.png",
              height: 66.66666666666667,
              width: 101.6666666666667,
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
                      fontSize: 9.666666666666667,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 90,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 21,
                      width: 63,
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
