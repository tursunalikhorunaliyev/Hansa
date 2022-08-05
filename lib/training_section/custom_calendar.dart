import 'dart:developer';
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
  bool  isEvent =  false;
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
        
        backgroundColor:const Color(0xFF232323),
        headerStyle: const DateRangePickerHeaderStyle(
          textStyle: TextStyle(color: Colors.white)
        ),
        
      onSelectionChanged: (date){
        List<DateTime> list1 = date.value as List<DateTime>;
        for(int i=0; i<listDate.length; i++){
          for(int j=i; j<list1.length; j++){
            if(listDate[i]==list1[j]){
              log("aaaaaaaaaaa");
            }
          }
        }
      },
       monthCellStyle: const DateRangePickerMonthCellStyle(
         disabledDatesTextStyle: TextStyle(color: Colors.white),
         textStyle: TextStyle(color: Colors.white),
       ),
       selectionMode: DateRangePickerSelectionMode.multiple,
        initialSelectedDates: listDate,
        selectableDayPredicate: (date) {
          if(listDate.contains(date)){
            return true;
          }
          else{
            return false;
          }
        },
      ),
    );
  }
}
