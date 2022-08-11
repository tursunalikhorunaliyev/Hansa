
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SobshitOProblemSuccess extends StatefulWidget {
  const SobshitOProblemSuccess({Key? key}) : super(key: key);

  @override
  State<SobshitOProblemSuccess> createState() => _SobshitOProblemSuccessState();
}

class _SobshitOProblemSuccessState extends State<SobshitOProblemSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.only(top: 120),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * .135),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 57.5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          color: Colors.white,
                          height: 170,
                          width: 350,
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      size: 22,
                                      color: Color(0xff8c8c8b),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            Icon(
                              Icons.check,
                              color: Color(0xFF25b049),
                            ),
                            Text(
                              "Спасибо за комментарий",
                              style: GoogleFonts.montserrat(
                                  color: const Color(0xff444444), fontSize: 24),
                            )
                          ]),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/LAB1.png",
                      height: 125,
                      width: 125,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
