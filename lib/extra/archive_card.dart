import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hansa_app/blocs/favourite_bloc.dart';
import 'package:provider/provider.dart';
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
      required this.linkPDF,
      required this.linkPDFSkachat,
      required this.isFavouriteURL})
      : super(key: key);

  final String url;
  final Color buttonColor;
  final String topButtonText;
  final String bottomButtonText;
  final String title;
  final Widget? skachat;
  final bool isFavourite;
  final String linkPDF;
  final String linkPDFSkachat;
  final String isFavouriteURL;

  @override
  State<ArchiveCard> createState() => _ArchiveCardState();
}

class _ArchiveCardState extends State<ArchiveCard> {
  late dynamic response;
  Future<void>? launched;
  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    final isFavouriteBLoC = FavouriteBLoC();
    final token = Provider.of<String>(context);
    bool fav = widget.isFavourite;
    return Padding(
      padding: EdgeInsets.only(top:isTablet?0: 15.h,bottom: isTablet?10:10, left:isTablet?0: 20, right:isTablet?0: 20),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: isTablet ? 180 : 217),
            child: Container(
              width: isTablet ? 390 : double.infinity,
              height: isTablet ? 85.h : 93.h,
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
               
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: isTablet ? 22.h : 27.h),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  launched = _launchInBrowser(Uri.parse(
                                      "http://${widget.linkPDFSkachat}"));
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: isTablet ? 100 : 94,
                                height: isTablet ? 28 : 25,
                                decoration: BoxDecoration(
                                    color: const Color(0xff31353b),
                                    borderRadius: BorderRadius.circular(13.r)),
                                child: Text(
                                  widget.topButtonText,
                                  style: GoogleFonts.montserrat(
                                      fontSize: isTablet ? 12 : 10,
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
              top: isTablet ? 150 : 181,
             
            ),
            child: Row(
mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(
                  flex: isTablet ? 13 : 9,
                ), 
                StreamBuilder<bool>(
                    stream: isFavouriteBLoC.stream,
                    initialData: false,
                    builder: (context, snapshot) {
                      return InkWell(
                        onTap: () {
                          fav = !fav;
                          isFavouriteBLoC.sink.add(fav);
                          isFavouriteBLoC.getFavourite(
                              token, widget.isFavouriteURL);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: isTablet ? 45 : 55,
                          width: isTablet ? 45 : 55,
                          decoration: BoxDecoration(
                              color: const Color(0xfff1f1f1),
                              borderRadius: BorderRadius.circular(90.w)),
                          child: fav
                              ? const Icon(
                                  Icons.favorite,
                                  color: Color(0xffed3851),
                                )
                              : const Icon(
                                  Icons.favorite_border_sharp,
                                  color: Color(0xffed3851),
                                ),
                        ),
                      );
                    }),
                 Spacer(
                  flex: isTablet ? 2 : 1,
                ) 
              ],
            ),
          ),
        ],
      ),
    );
  }

  _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
