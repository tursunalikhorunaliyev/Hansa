import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/extra/custom_paint_clipper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CustomStatiTabletItem extends StatelessWidget {
  const CustomStatiTabletItem({
    Key? key,
    required this.backgroundColor,
    required this.buttonTextColor,
    required this.buttonColor,
    required this.titleColor,
    required this.buttonText,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final Color backgroundColor;
  final Color buttonTextColor;
  final Color buttonColor;
  final Color titleColor;
  final String buttonText;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h, bottom: 3.h),
      child: SizedBox(
        width: 190,
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
                      width: 350,
                      height: 110,
                      color: backgroundColor,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.w, top: 5, bottom: 5),
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 100,
                    child: Text(
                      title,
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.montserrat(
                        color: titleColor,
                        fontSize: 7.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Row(
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
                            height: 35,
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            color: buttonColor,
                            child: Center(
                              child: Text(
                                buttonText,
                                style: GoogleFonts.montserrat(
                                  color: buttonTextColor,
                                  fontSize: 7.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
