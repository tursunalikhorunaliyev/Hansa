import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EventCards extends StatelessWidget {
  const EventCards(
      {Key? key,
      required this.buttonColor,
      required this.buttonText,
      required this.month,
      required this.title,
      required this.isDate,
      required this.day,
      required this.url,
      required this.isFavourite,
      required this.onTab})
      : super(key: key);
  final String url;
  final Color buttonColor;
  final String month;
  final String day;
  final String buttonText;
  final String title;
  final bool isDate;
  final bool isFavourite;
  final VoidCallback onTab;
  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: isTablet ? 180 : 217),
            child: Container(
              width: isTablet ? 390 : double.infinity,
              height: 93,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xffffffff)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        overflow: TextOverflow.fade,
                        style: GoogleFonts.montserrat(
                            fontSize: isTablet ? 14 : 12,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 23),
                      child: GestureDetector(
                        onTap: onTab,
                        child: Container(
                          alignment: Alignment.center,
                          width: isTablet ? 100 : 94,
                          height: isTablet ? 28 : 25,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: const Color(0xffff163e),
                              borderRadius: BorderRadius.circular(13)),
                          child: Text(
                            buttonText,
                            style: GoogleFonts.montserrat(
                                fontSize: isTablet ? 12 : 10,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
              width: isTablet ? 388 : double.infinity,
              height: isTablet ? 170 : 206,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                ),
              )),
          isDate
              ? Padding(
                  padding: EdgeInsets.only(top: 80, left: isTablet ? 150 : 0),
                  child: Row(
                    children: [
                      Spacer(),
                      Container(
                        padding: const EdgeInsets.all(12),
                        height: isTablet ? 65 : 65,
                        width: isTablet ? 65 : 65,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              day,
                              style: TextStyle(fontSize: isTablet ? 14 : 11),
                            ),
                            Text(
                              month,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: isTablet ? 9 : 9),
                            ),
                          ],
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                )
              : const SizedBox(),
          Padding(
            padding: EdgeInsets.only(
                top: isTablet ? 150 : 181, left: isTablet ? 305 : 0),
            child: Row(
              children: [
                Spacer(
                  flex: 9,
                ),
                Container(
                  alignment: Alignment.center,
                  height: isTablet ? 45 : 55,
                  width: isTablet ? 45 : 55,
                  decoration: const BoxDecoration(
                      color: Color(0xfff1f1f1), shape: BoxShape.circle),
                  child: isFavourite
                      ? const Icon(
                          Icons.favorite,
                          color: Color(0xffed3851),
                        )
                      : const Icon(
                          Icons.favorite_border_sharp,
                          color: Color(0xffed3851),
                        ),
                ),
                Spacer(
                  flex: 1,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
