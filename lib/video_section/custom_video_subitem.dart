import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomVideoSubItem extends StatelessWidget {
  const CustomVideoSubItem({Key? key, required this.title, required this.onTap})
      : super(key: key);
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 325,
      child: Row(
        children: [
          Container(
            height: 10,
            width: 10,
            decoration: const BoxDecoration(
              color: Color(0xffff163e),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: GoogleFonts.montserrat(
              color: const Color(0xff33383f),
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
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
                  color: const Color(0xffff163e),
                  child: Center(
                    child: Text(
                      "Открыть раздел",
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
    );
  }
}
