import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ObucheniyaCard extends StatefulWidget {
  const ObucheniyaCard(
      {Key? key,
      required this.buttonColor,
      required this.bottomButtonText,
      required this.title,
      required this.url,
      required this.isFavourite,
      required this.linkPDF})
      : super(key: key);
  final String url;
  final Color buttonColor;
  final String bottomButtonText;
  final String title;
  final bool isFavourite;
  final String linkPDF;

  @override
  State<ObucheniyaCard> createState() => _ObucheniyaCardState();
}

class _ObucheniyaCardState extends State<ObucheniyaCard> {
  late dynamic response;
  Future<void>? launched;
  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    return Padding(
      padding: EdgeInsets.only(top: 15.h, left: 20, right: 20),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: isTablet ? 180 : 217),
            child: Container(
              width: isTablet ? 390 : double.infinity,
              height: isTablet ? 75.h : 93.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: const Color(0xffffffff)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        overflow: TextOverflow.fade,
                        style: GoogleFonts.montserrat(
                            fontSize: isTablet ? 14 : 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 23.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                launched = _launchInBrowser(
                                    Uri.parse("http://${widget.linkPDF}"));
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: isTablet ? 100 : 94,
                              height: isTablet ? 28 : 25,
                              decoration: BoxDecoration(
                                  color: widget.buttonColor,
                                  borderRadius: BorderRadius.circular(13.r)),
                              child: Text(
                                widget.bottomButtonText,
                                style: GoogleFonts.montserrat(
                                    fontSize: isTablet ? 12 : 10,
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
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
                borderRadius: BorderRadius.circular(5.r),
                child: Image.network(
                  widget.url,
                  fit: BoxFit.cover,
                ),
              )),
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
                  decoration: BoxDecoration(
                      color: const Color(0xfff1f1f1),
                      borderRadius: BorderRadius.circular(90.w)),
                  child: widget.isFavourite
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

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
