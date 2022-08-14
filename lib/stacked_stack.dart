import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/favourite_model.dart';
import 'package:hansa_app/blocs/favourite_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class StackedStack extends StatelessWidget {
  const StackedStack({Key? key, required this.buttonColor,
      required this.buttonText,
      required this.month,
      required this.title,
      required this.isDate,
      required this.day,
      required this.url,
      required this.isFavouriteURL,
      required this.isFavourite,
      required this.onTap}) : super(key: key);

  final String url;
  final String isFavouriteURL;
  final Color buttonColor;
  final String month;
  final String day;
  final String buttonText;
  final String title;
  final bool isDate;
  final bool isFavourite;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {

    final isFavouriteBLoC = FavouriteBLoC();
    final token = Provider.of<String>(context);
    final favouriteModel = FavouriteModel(status: true, data: true);
    bool fav = isFavourite;
    return  Center(
        child: SizedBox(
          height: 300 ,
          width: 390,
          child: Stack(
            children: [
              Column(
                children: [
                           SizedBox(
                    width: 388,
                    height: 170,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 388,
                          height: 170,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: url,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        isDate
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        height: 65,
                                        width: 65,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              day,
                                              style: TextStyle(fontSize: 11),
                                            ),
                                            Text(
                                              month,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 9),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ],
                    )),
                //  Spacer(),
                SizedBox(height: 10,),
                          Container(
                  width: 390,
                  height: 75.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xffffffff)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      softWrap: true,
                            style: GoogleFonts.montserrat(
                                fontSize: 14, fontWeight: FontWeight.w800),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 23.w),
                          child: GestureDetector(
                            onTap: onTap,
                            child: Container(
                              alignment: Alignment.center,
                              width: 100,
                              height: 28,
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
                                    fontSize: 12,
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
                ],
              ),
          
                 StreamBuilder<bool>(
                      initialData: false,
                      stream: isFavouriteBLoC.stream,
                      builder: (context, snapshot) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60,right: 38),
                            child: InkWell(
                                onTap: () {
                            fav = !fav;
                            isFavouriteBLoC.sink.add(fav);
                            isFavouriteBLoC.getFavourite(token, isFavouriteURL);
                          },
                              child: Container(
                                alignment: Alignment.center,
                                height: 45 ,
                                width:  45 ,
                                decoration: const BoxDecoration(
                                    color: Color(0xfff1f1f1), shape: BoxShape.circle),
                                child: (fav)
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
}
