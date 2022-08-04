import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomOKompaniiItem extends StatelessWidget {
  const CustomOKompaniiItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.onTap,
    required this.onDownload,
  }) : super(key: key);
  final String imageUrl;
  final String title;
  final VoidCallback onTap;
  final VoidCallback onDownload;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            height: 165,
            width: 325,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 100,
            width: 325,
            color: const Color(0xffffffff),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: SizedBox(
                    width: 200,
                    child: Text(
                      title,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.montserrat(
                        color: const Color(0xff272624),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 8,
                    top: 18,
                    bottom: 18,
                  ),
                  child: Column(
                    children: [
                      PhysicalModel(
                        shadowColor: Colors.grey.withOpacity(.5),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(64),
                        elevation: 5,
                        child: GestureDetector(
                          onTap: onTap,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(64),
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              constraints: const BoxConstraints(
                                minWidth: 90,
                              ),
                              color: const Color(0xff1c2c45),
                              child: Center(
                                child: Text(
                                  "Смотреть",
                                  style: GoogleFonts.montserrat(
                                    color: const Color(0xffffffff),
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      PhysicalModel(
                        shadowColor: Colors.grey.withOpacity(.5),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(64),
                        elevation: 5,
                        child: GestureDetector(
                          onTap: onDownload,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(64),
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              constraints: const BoxConstraints(
                                minWidth: 90,
                              ),
                              color: const Color(0xffff163e),
                              child: Center(
                                child: Text(
                                  "Скачать",
                                  style: GoogleFonts.montserrat(
                                    color: const Color(0xffffffff),
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
