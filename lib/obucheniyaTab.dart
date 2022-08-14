import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/favourite_model.dart';
import 'package:hansa_app/blocs/favourite_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class StackedStackObuch extends StatefulWidget {
  StackedStackObuch(
      {Key? key,
      required this.buttonColor,
      required this.bottomButtonText,
      required this.title,
      required this.url,
      required this.isFavourite,
      required this.linkPDF,
      required this.isFavouriteURL})
      : super(key: key);

  final String url;
  final Color buttonColor;
  final String bottomButtonText;
  final String title;
  final bool isFavourite;
  final String linkPDF;
  final String isFavouriteURL;

  @override
  State<StackedStackObuch> createState() => _StackedStackObuchState();
}

class _StackedStackObuchState extends State<StackedStackObuch> {
  late dynamic response;

  Future<void>? launched;

  @override
  Widget build(BuildContext context) {
    final isFavouriteBLoC = FavouriteBLoC();
    final token = Provider.of<String>(context);
    final favouriteModel = FavouriteModel(status: true, data: true);
    bool fav = widget.isFavourite;
    return Center(
      child: SizedBox(
        height: 300,
        width: 390,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                    width: 388,
                    height: 170,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
                      child: Image.network(
                        widget.url,
                        fit: BoxFit.cover,
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 390,
                  height: 75.h,
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
                                fontSize: 14, fontWeight: FontWeight.bold),
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
                                  width: 100,
                                  height: 28,
                                  decoration: BoxDecoration(
                                      color: widget.buttonColor,
                                      borderRadius:
                                          BorderRadius.circular(13.r)),
                                  child: Text(
                                    widget.bottomButtonText,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12,
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
              ],
            ),
            StreamBuilder<bool>(
                initialData: false,
                stream: isFavouriteBLoC.stream,
                builder: (context, snapshot) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60, right: 38),
                      child: InkWell(
                        onTap: () {
                          fav = !fav;
                          isFavouriteBLoC.sink.add(fav);
                          isFavouriteBLoC.getFavourite(
                              token, widget.isFavouriteURL);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 45,
                          width: 45,
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
                      ),
                    ),
                  );
                }),
          ],
        ),
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
