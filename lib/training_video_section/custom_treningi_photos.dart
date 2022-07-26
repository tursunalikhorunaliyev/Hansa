import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTreningiPhotos extends StatelessWidget {
  const CustomTreningiPhotos({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final page = PageController(initialPage: 0);
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: SizedBox(
        width: 345,
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 156,
                            maxWidth: 325,
                          ),
                          child: PageView.builder(
                            allowImplicitScrolling: true,
                            physics: const BouncingScrollPhysics(),
                            controller: page,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Center(
                                child: SizedBox(
                                  height: 156,
                                  width: 325,
                                  child: Image.asset(
                                    "assets/tt.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          height: 156,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (page.hasClients && !(page.offset < 325)) {
                              page.animateTo(
                                page.offset - 300,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.bounceIn,
                              );
                            }
                          },
                          child: Container(
                            height: 35,
                            width: 27,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                              color: Color(0xffff163e),
                            ),
                            child: Center(
                              child: Image.asset(
                                "assets/back.png",
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (page.hasClients && page.offset < 4 * 325) {
                              page.animateTo(
                                page.offset + 300,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.ease,
                              );
                            }
                          },
                          child: Container(
                            height: 35,
                            width: 27,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              color: Color(0xffff163e),
                            ),
                            child: Center(
                              child: Image.asset(
                                "assets/forward.png",
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 11,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 90,
                    width: 325,
                    color: const Color(0xffffffff),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Иммерсивное шоу\n\"Увидимся на кухне\"г.\nЕкатеринбург:     18.04.2019",
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(64),
                              child: Container(
                                height: 25,
                                width: 95,
                                color: const Color(0xffff163e),
                                child: Center(
                                  child: Text(
                                    "Скачать",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      color: const Color(0xffffffff),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 131,
              right: 25,
              child: Container(
                height: 55,
                width: 55,
                decoration: const BoxDecoration(
                  color: Color(0xfff1f1f1),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.favorite,
                    color: Color(0xffed3851),
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
