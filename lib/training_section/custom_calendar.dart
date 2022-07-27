import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCalendar extends StatelessWidget {
  const CustomCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    return Padding(
      padding:
          EdgeInsets.only(left: 25.w, right: 25.w, top: isTablet ? 12.h : 0.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isTablet ? 12.r : 9.r),
        child: Container(
          width: 325.w,
          height: 180.w,
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
          ),
          color: const Color(0xff232323),
          child: TableCalendar(
            focusedDay: DateTime(2022, 06, 09),
            currentDay: DateTime(2022, 06, 09),
            firstDay: DateTime(2000),
            lastDay: DateTime(2050),
            headerStyle: HeaderStyle(
              decoration: const BoxDecoration(color: Color(0xff232323)),
              leftChevronIcon: const Icon(
                CupertinoIcons.chevron_back,
                color: Color(0xffaaaaaa),
              ),
              rightChevronIcon: const Icon(
                CupertinoIcons.chevron_forward,
                color: Color(0xffaaaaaa),
              ),
              titleTextStyle: GoogleFonts.montserrat(color: Colors.white),
              titleCentered: true,
              formatButtonVisible: false,
            ),
            weekendDays: const [1, 2, 3, 4, 5, 6, 7],
            daysOfWeekHeight: 40.h,
            daysOfWeekStyle: DaysOfWeekStyle(
              decoration: const BoxDecoration(
                color: Color(0xff232323),
              ),
              weekdayStyle: GoogleFonts.montserrat(
                color: const Color(0xffb9baba),
              ),
              weekendStyle: GoogleFonts.montserrat(
                color: const Color(0xffb9baba),
              ),
            ),
            rowHeight: 40.h,
            calendarStyle: CalendarStyle(
              cellMargin: const EdgeInsets.all(.5),
              rowDecoration: const BoxDecoration(
                color: Color(0xff232323),
              ),
              outsideDecoration: const BoxDecoration(
                color: Color(0xff1d1d1d),
              ),
              todayDecoration: const BoxDecoration(
                color: Color(0xffff163e),
              ),
              outsideTextStyle: GoogleFonts.montserrat(
                color: const Color(0xffb9baba),
              ),
              defaultTextStyle: GoogleFonts.montserrat(
                color: const Color(0xffb9baba),
              ),
              weekendTextStyle: GoogleFonts.montserrat(
                color: const Color(0xffb9baba),
              ),
              todayTextStyle: GoogleFonts.montserrat(
                color: const Color(0xffb9baba),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
