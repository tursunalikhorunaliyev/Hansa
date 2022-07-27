import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReferalSilka extends StatelessWidget {
  const ReferalSilka({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.only(left: isTablet ? 30 : 82),
          child: Text(
            "Реферальная ссылка",
            style: GoogleFonts.montserrat(
                fontSize: isTablet ? 17 : 13, color: const Color(0xFFaaaaaa)),
          ),
        ),
        SizedBox(
          height: isTablet ? 30 : 0,
        ),
        Divider(
          color: const Color(0xFF444444),
          thickness: 2,
          indent: isTablet ? 10 : 72,
          endIndent: isTablet ? 10 : 26,
        ),
         SizedBox(
          height: isTablet ? 20  : 19,
        ),
        Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: isTablet ? 30 : 82),
              child: Text(
                "http://hansa-lab.ru/?ref=68",
                style: GoogleFonts.montserrat(
                    fontSize: isTablet ? 17 : 10,
                    color: const Color(0xFFffffff)),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Image.asset(
              "assets/free-icon-sharethis-1532422.png",
              height: isTablet ? 30 : 20,
              width: isTablet ? 30 : 20,
            ),
            SizedBox(
            height: isTablet ? 60  : 0,
          ),
            Divider(
              color: const Color(0xFF444444),
              thickness: 2,
              indent: isTablet ? 10 : 72,
              endIndent: isTablet ? 10 : 26,
            ),
          ],
        ),
      ],
    );
  }
}
