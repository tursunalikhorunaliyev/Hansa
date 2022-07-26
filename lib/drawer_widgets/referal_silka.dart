import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReferalSilka extends StatelessWidget {
  const ReferalSilka({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 82),
          child: Text(
            "Реферальная ссылка",
            style: GoogleFonts.montserrat(
                fontSize: 13, color: const Color(0xFFaaaaaa)),
          ),
        ),
        const Divider(
          color: Color(0xFF444444),
          thickness: 2,
          indent: 72,
          endIndent: 26,
        ),
        const SizedBox(
          height: 19,
        ),
        Wrap(
          direction: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 82),
              child: Text(
                "http://hansa-lab.ru/?ref=68",
                style: GoogleFonts.montserrat(
                    fontSize: 10, color: const Color(0xFFffffff)),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Image.asset(
              "assets/free-icon-sharethis-1532422.png",
              height: 20,
              width: 20,
            ),
            const Divider(
              color: Color(0xFF444444),
              thickness: 2,
              indent: 72,
              endIndent: 26,
            ),
          ],
        ),
      ],
    );
  }
}
