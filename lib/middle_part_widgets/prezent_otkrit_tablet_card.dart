import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/blocs/favourite_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class PrezentOtkritTabletCard extends StatefulWidget {
  const PrezentOtkritTabletCard({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  final String url;
  final String title;

  @override
  State<PrezentOtkritTabletCard> createState() =>
      _PrezentOtkritTabletCardState();
}

class _PrezentOtkritTabletCardState extends State<PrezentOtkritTabletCard> {
  late dynamic response;
  Future<void>? launched;
  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    final isFavouriteBLoC = FavouriteBLoC();
    final token = Provider.of<String>(context);
    return Center(
      child: SizedBox(
        height: 360,
        width: 430,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              InkWell(
                onTap: () {},
                child: SizedBox(
                    width: 410,
                    height: 230,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
                      child: CachedNetworkImage(
                        imageUrl: widget.url,
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 410,
                height: 77.h,
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
                            Padding(
                              padding: EdgeInsets.only(top: 4.h),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  alignment: Alignment.center,
                                  width: isTablet ? 100 : 94,
                                  height: isTablet ? 28 : 25,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius:
                                          BorderRadius.circular(13.r)),
                                  child: Text(
                                    "Salom",
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
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
