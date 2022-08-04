import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/extra/custom_paint_clipper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TabletItemTreningi extends StatelessWidget {
  const TabletItemTreningi(
      {Key? key,
      required this.backgroundColor,
      required this.buttonTextColor,
      required this.buttonColor,
      required this.titleColor,
      required this.buttonText,
      required this.title,
      required this.onTap})
      : super(
          key: key,
        );

  final Color backgroundColor;
  final Color buttonTextColor;
  final Color buttonColor;
  final Color titleColor;
  final String buttonText;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    return Padding(
      padding: EdgeInsets.only(top: 11.h, bottom: 5.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.r),
                child: ClipPath(
                  clipper: CustomPaintClipper(),
                  child: Container(
                    width: 140.w,
                    height: 71.h,
                    color: backgroundColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 27.w),
                child: Text(
                  title,
                  style: GoogleFonts.montserrat(
                    color: titleColor,
                    fontSize: 7.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Row(
                  children: [
                    PhysicalModel(
                      shadowColor: Colors.grey.withOpacity(.5),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(64.r),
                      elevation: 5.sp,
                      child: GestureDetector(
                        onTap: onTap,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(64.r),
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            constraints: BoxConstraints(
                              minWidth: 55.w,
                            ),
                            color: buttonColor,
                            child: Center(
                              child: Text(
                                buttonText,
                                style: GoogleFonts.montserrat(
                                  color: buttonTextColor,
                                  fontSize: 8.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
