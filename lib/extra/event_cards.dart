import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      required this.url})
      : super(key: key);
  final String url;
  final Color buttonColor;
  final String month;
  final String day;
  final String buttonText;
  final String title;
  final bool isDate;
  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 167.h),
              child: Container(
                width: isTablet ? 175.w : 325.w,
                height: 93.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: const Color(0xffffffff)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 11),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          overflow: TextOverflow.fade ,
                          style: GoogleFonts.montserrat(
                              fontSize: isTablet ? 8.sp  : 12.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 23.w),
                        child: Container(
                          alignment: Alignment.center,
                          width: isTablet ? 60.w  : 94.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: const Color(0xffff163e),
                              borderRadius: BorderRadius.circular(13.r)),
                          child: Text(
                            buttonText,
                            style: GoogleFonts.montserrat(
                                fontSize: isTablet ?  8.sp  :   10.sp,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: isTablet ?  1 : 0),
              child: SizedBox(
                  width: isTablet ? 175.w : 326.w,
                  height: 156.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.r),
                    child: Image.asset(
                      url,
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            isDate
                ? Padding(
                    padding: EdgeInsets.only(top: 50.h, left: isTablet ?  70.w  :  136.w),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      height: isTablet ? 35.w : 55.h,
                      width: isTablet ? 35.w : 55.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Text(
                            day,
                            style: TextStyle(fontSize: isTablet ? 8.sp : 11.sp),
                          ),
                          Text(
                            month,
                            style: TextStyle(fontSize: isTablet ? 8.sp : 11.sp),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
            Padding(  
              padding:
                  EdgeInsets.only(top: isTablet ? 143.h  : 131.h, left: isTablet ? 130.w : 247.w),
              child: Container(
                alignment: Alignment.center,
                height: isTablet ? 35.h : 55.h,
                width: isTablet ? 35.w : 55.h,
                decoration: const BoxDecoration(
                    color: Color(0xfff1f1f1), shape: BoxShape.circle),
                child: Icon(
                  CupertinoIcons.heart_fill,
                  size: isTablet ? 15.sp  : 28.sp,
                  color: const Color(0xffed3851),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
