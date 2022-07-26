import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArchiveCard extends StatelessWidget {
  const ArchiveCard(
      {Key? key,
      required this.buttonColor,
      required this.topButtonText,
      required this.skachat,
      required this.bottomButtonText,
      required this.title,
      required this.url})
      : super(key: key);
  final String url;
  final Color buttonColor;
  final String topButtonText;
  final String bottomButtonText;
  final String title;
  final Widget? skachat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 15.h),
      child: Stack(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 167.h),
            child: Container(
              width: 325.w,
              height: 93.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: const Color(0xffffffff)),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 7.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        overflow: TextOverflow.fade,
                        style: GoogleFonts.montserrat(
                            fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 23.w),
                      child: Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top: 27.h),
                            child: Container(
                              alignment: Alignment.center,
                              width: 94.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                  color: const Color(0xff31353b),
                                  borderRadius: BorderRadius.circular(13.r)),
                              child: Text(
                                topButtonText,
                                style: GoogleFonts.montserrat(
                                    fontSize: 10.sp,
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top: 4.h),
                            child: Container(
                              alignment: Alignment.center,
                              width: 94.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                  color: buttonColor,
                                  borderRadius: BorderRadius.circular(13.r)),
                              child: Text(
                                bottomButtonText,
                                style: GoogleFonts.montserrat(
                                    fontSize: 10.sp,
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
              width: 326.w,
              height: 156.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.r),
                child: Image.network(
                  url,
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
              child: const Icon(
                Icons.favorite,
                color: Color(0xffed3851),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
