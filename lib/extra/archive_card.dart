import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class ArchiveCard extends StatefulWidget {
  const ArchiveCard(
      {Key? key,
      required this.buttonColor,
      required this.topButtonText,
      required this.skachat,
      required this.bottomButtonText,
      required this.title,
      required this.url,
      required this.isFavourite,
      required this.linkPDF})
      : super(key: key);
  final String url;
  final Color buttonColor;
  final String topButtonText;
  final String bottomButtonText;
  final String title;
  final Widget? skachat;
  final bool isFavourite;
  final String linkPDF;

  @override
  State<ArchiveCard> createState() => _ArchiveCardState();
}

class _ArchiveCardState extends State<ArchiveCard> {
  late dynamic response;
  Future<void>? launched;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.h),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 167.h),
            child: Container(
              width: 325.w,
              height: 93.h,
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
                            fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 23.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 27.h),
                            child: InkWell(
                              onTap: () {
                                setState(() async {
                                  
                                  launched = _launchInBrowser(
                                      Uri.parse("http://" + widget.linkPDF));
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 94.w,
                                height: 25.h,
                                decoration: BoxDecoration(
                                    color: const Color(0xff31353b),
                                    borderRadius: BorderRadius.circular(13.r)),
                                child: Text(
                                  widget.topButtonText,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 10.sp,
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  launched = _launchInBrowser(
                                      Uri.parse("http://" + widget.linkPDF));
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 94.w,
                                height: 25.h,
                                decoration: BoxDecoration(
                                    color: widget.buttonColor,
                                    borderRadius: BorderRadius.circular(13.r)),
                                child: Text(
                                  widget.bottomButtonText,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 10.sp,
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w500),
                                ),
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
              width: 326.w,
              height: 156.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.r),
                child: Image.network(
                  widget.url,
                  fit: BoxFit.cover,
                ),
              )),
          Padding(
            padding: EdgeInsets.only(top: 131.h, left: 247.w),
            child: Container(
              alignment: Alignment.center,
              height: 55.h,
              width: 55.w,
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
