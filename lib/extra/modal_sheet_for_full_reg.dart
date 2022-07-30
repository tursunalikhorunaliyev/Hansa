import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hansa_app/enums/full_reg_enum.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ModalForFullReg extends StatefulWidget {
   FullRegEnum regEnum;
   String text;
   double width;
   double height;
   double size;
   FontWeight fontWeight;


  ModalForFullReg({Key? key, required this.regEnum, required this.text,required this.fontWeight, required this.size, required this.height, required this.width }) : super(key: key);

  @override
  State<ModalForFullReg> createState() => _ModalForFullRegState();
}

class _ModalForFullRegState extends State<ModalForFullReg> {
  final dateRangeController = DateRangePickerController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 11,
        right: 9,
      ),
      child: GestureDetector(
        onTap: () {
          showCupertinoModalPopup(context: context, builder: (context){
            return Container(
              width: 360,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: SfDateRangePicker(
                controller: dateRangeController,
                selectionColor: Colors.pink[600],
                todayHighlightColor: Colors.pink[600],
                onSelectionChanged: (a){
                  print(dateRangeController.selectedDate);
                  Navigator.pop(context);
                },
              )
            );
          });
        },
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            color: const Color(0xFFffffff),
            borderRadius: BorderRadius.circular(54),
            border: Border.all(width: 0.1),
          ),
          ),
      ));
  }
}