import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomBlackAppBar extends StatelessWidget {
  const CustomBlackAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 81.h,
      color: const  Color(0xff333333),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children:  [
              SizedBox(
                height: 20.h,
              ),
              Icon(
                Icons.menu,
                color: const Color(0xffffffff),
                size: 25.sp,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: 13.h),
                child: Image.asset(
                  'assets/hansa_white.png',
                  height: 25.h,
                  width: 214.w,
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: 5.h),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "#Увидимся",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffff163e),
                        ),
                      ),
                      TextSpan(
                        text: "на",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.normal,
                          color: const Color(0xffff163e),
                        ),
                      ),
                      TextSpan(
                        text: "кухне",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffff163e),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Column(
            children:  [
              SizedBox(
                height: 20.h,
              ),
              Icon(
                Icons.search,
                size: 25.sp,
                color:const Color(0xffffffff),
              ),
            ],
          ),
        ],
      ),
    );
  }
}