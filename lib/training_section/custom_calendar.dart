import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCalendar extends StatefulWidget {
  final List dates;
  const CustomCalendar({Key? key, required this.dates}) : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  bool isEvent = false;
  @override
  Widget build(BuildContext context) {
    List<DateTime> listDate = [];
    for (String element in widget.dates) {
      List<String> date = element.split('-');
      listDate.add(
        DateTime(
          int.parse(date[0]),
          int.parse(date[1]),
          int.parse(date[2].substring(0, 2)),
        ),
      );
    }
    final isTablet = Provider.of<bool>(context);
    return Padding(
      padding:
          EdgeInsets.only(left: 25.w, right: 25.w, top: isTablet ? 12.h : 0.h),
      child: SfDateRangePicker(
       
        todayHighlightColor: Colors.white,
        
        monthViewSettings: const DateRangePickerMonthViewSettings(
    
         viewHeaderStyle: DateRangePickerViewHeaderStyle(
        
           textStyle: TextStyle(color: Colors.white)
         )
        ),
        
        selectionColor: Colors.red,
       
        
        selectionShape: DateRangePickerSelectionShape.rectangle,
        backgroundColor: const Color(0xFF232323),
        headerStyle: const DateRangePickerHeaderStyle(
            textStyle: TextStyle(color: Colors.white)),
        onSelectionChanged: (date) {
          List<DateTime> list1 = date.value as List<DateTime>;
          if (listDate.length != list1.length) {}
        },
        monthCellStyle: DateRangePickerMonthCellStyle(
          cellDecoration: BoxDecoration(
            color:  Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
        
          disabledDatesDecoration: BoxDecoration(
              color: const Color(0xFF232323),
              borderRadius: BorderRadius.circular(0)),
          disabledDatesTextStyle: const TextStyle(color: Colors.white),
          textStyle: const TextStyle(color: Colors.white),
        ),
        selectionMode: DateRangePickerSelectionMode.multiple,
        initialSelectedDates: listDate,
        selectableDayPredicate: (date) {
          if (listDate.contains(date)) {
            return true;
          } else {
            return false;
          }
        },
      ),
    );
  }
}
