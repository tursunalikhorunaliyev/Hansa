import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class IpadContainer extends StatelessWidget {
  final String title;
  final Color titleColor;
  const IpadContainer({Key? key, required this.title, required this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Container(
            alignment: Alignment.center,
            height: 120.h,
            width: 325.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: const Color(0xffff163e),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: SizedBox(
                width: 500,
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  softWrap: true,
                  style: GoogleFonts.montserrat(
                    color: titleColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 98.h, left: 54.w),
          child: Container(
            alignment: Alignment.center,
            height: 55.h,
            width: 220.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.r),
                color: const Color(0xff25b049)),
            child: Text(
              'Записаться',
              style: GoogleFonts.montserrat(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
