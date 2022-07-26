import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/extra/event_cards.dart';
import 'package:provider/provider.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: isTablet ? 20.h  : 9.h),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: isTablet ? 50.w : 70.w,
                    height: isTablet ? 58.h : 42.h,
                    decoration: BoxDecoration(
                        color: const Color(0XFFff163e),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(isTablet ? 30.r  : 21.r),
                            bottomRight: Radius.circular(isTablet ? 30.r  : 21.r))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Image.asset(
                        'assets/Lab.png',
                        height:isTablet ? 14.h  : 12.h,
                        width: 42.w,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text(
                      '#',
                      style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xffff163e)),
                    ),
                  ),
                  Text(
                    'Добро пожаловать',
                    style: GoogleFonts.montserrat(
                        fontSize: isTablet ? 14.sp  : 20.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff272624)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: isTablet ? 780.h : 591.h,
              width: isTablet ? 360.w : 330.w,
              child: isTablet
                  ? SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image.asset(
                              "assets/dobriy.png",
                              width: 900,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Column(
                            children: List.generate(
                                20,
                                (index) => Row(
                                      children: [
                                        Padding(
                                            padding:
                                                EdgeInsets.only(top: 5.0.h),
                                            child: const EventCards(
                                              buttonColor: Color(0xffff163e),
                                              buttonText: 'Смотреть',
                                              isDate: true,
                                              month: "июля",
                                              day: "8",
                                              title:
                                                  '''Минутка ностальгии: смотрим отчеты с тренинговв Екатеринбурге и Перми!''',
                                              url: 'assets/A.png',
                                            )),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(top: 5.0.h),
                                            child: const EventCards(
                                              buttonColor: Color(0xffff163e),
                                              buttonText: 'Смотреть',
                                              isDate: true,
                                              month: "июля",
                                              day: "8",
                                              title:
                                                  '''Минутка ностальгии: смотрим отчеты с тренинговв Екатеринбурге и Перми!''',
                                              url: 'assets/A.png',
                                            )),
                                      ],
                                    )),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: List.generate(
                            20,
                            (index) => Padding(
                                padding: EdgeInsets.only(top: 5.0.h),
                                child: const EventCards(
                                  buttonColor: Color(0xffff163e),
                                  buttonText: 'Смотреть',
                                  isDate: true,
                                  month: "июля",
                                  day: "8",
                                  title:
                                      '''Минутка ностальгии: смотрим отчеты с тренинговв Екатеринбурге и Перми!''',
                                  url: 'assets/A.png',
                                ))),
                      ),
                    ),
            )
          ],
        ),
      ],
    );
  }
}
