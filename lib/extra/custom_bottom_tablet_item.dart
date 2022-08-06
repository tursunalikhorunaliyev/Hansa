import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/extra/custom_paint_clipper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabletKatalogBottomItem extends StatelessWidget {
  const TabletKatalogBottomItem({
    Key? key,
    required this.backgroundColor,
    required this.buttonTextColor,
    required this.buttonColor,
    required this.titleColor,
    required this.stbuttonText,
    required this.ndbuttonText,
    required this.title,
  }) : super(key: key);

  final Color backgroundColor;
  final Color buttonTextColor;
  final Color buttonColor;
  final Color titleColor;
  final String stbuttonText;
  final String ndbuttonText;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 11.h,
      ),
      child: SizedBox(
        width: 200.w,
        child: Stack(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.r),
                  child: ClipPath(
                    clipper: CustomPaintClipper(),
                    child: Container(
                      width: 150.w,
                      height: 65.h,
                      color: backgroundColor,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Container(
                      alignment: Alignment.center,
                      width: 100.w,
                      height: 60.h,
                      child: Text(
                        title,
                        overflow: TextOverflow.fade,
                        style: GoogleFonts.montserrat(
                          color: titleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 7.sp,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      PhysicalModel(
                        shadowColor: Colors.grey.withOpacity(.5),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(64.r),
                        elevation: 5.sp,
                        child: GestureDetector(
                          onTap: () {},
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(64.r),
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              width: 50.w,
                              height: 20.h,
                              color: buttonColor,
                              child: Center(
                                child: Text(
                                  stbuttonText,
                                  style: GoogleFonts.montserrat(
                                    color: buttonTextColor,
                                    fontSize: 6.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PhysicalModel(
                        shadowColor: Colors.grey.withOpacity(.5),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(64),
                        elevation: 5,
                        child: GestureDetector(
                          onTap: () {},
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(64),
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              width: 50.w,
                              height: 20.h,
                              color: buttonColor,
                              child: Center(
                                child: Text(
                                  ndbuttonText,
                                  style: GoogleFonts.montserrat(
                                    color: buttonTextColor,
                                    fontSize: 6.sp,
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
            ),
          ],
        ),
      ),
    );
  }
}
