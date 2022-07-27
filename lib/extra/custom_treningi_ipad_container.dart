import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class IpadContainer extends StatelessWidget {
  const IpadContainer({Key? key}) : super(key: key);

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
              child: Column(
                children: [
                  Text(
                    " Иммерсивное шоу",
                    style: GoogleFonts.montserrat(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Text(
                    " \"Увидимся на кухне\"",
                    style: GoogleFonts.montserrat(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ],
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
