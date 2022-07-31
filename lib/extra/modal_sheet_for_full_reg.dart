import 'package:filter_list/filter_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/enums/full_reg_enum.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
class ModalForFullReg extends StatefulWidget {
   final FullRegEnum regEnum;
   final String text;
   final double width;
   final double height;
   final double size;
   final FontWeight fontWeight;


  const ModalForFullReg({Key? key, required this.regEnum, required this.text,required this.fontWeight, required this.size, required this.height, required this.width }) : super(key: key);

  @override
  State<ModalForFullReg> createState() => _ModalForFullRegState();
}

class _ModalForFullRegState extends State<ModalForFullReg> {
  final dateRangeController = DateRangePickerController();
  String dataRojdeniya = "";
  String selectedText = "Salom";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 11,
        right: 9,
      ),
      child: GestureDetector(
        onTap: () {
          if(widget.regEnum == FullRegEnum.dataRojdeniya){
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
                  String day = dateRangeController.selectedDate!.day.toString().length==1?"0"+dateRangeController.selectedDate!.day.toString():dateRangeController.selectedDate!.day.toString();
                  String month = dateRangeController.selectedDate!.month.toString().length==1?"0"+dateRangeController.selectedDate!.month.toString():dateRangeController.selectedDate!.month.toString();
                  String year = dateRangeController.selectedDate!.year.toString();
                 setState(() {
                   dataRojdeniya = day+"."+month+"."+year;
                 });
                  Navigator.pop(context);
                },
              )
            );
          });
          }
          else if(widget.regEnum == FullRegEnum.doljnost){
            
             FilterListDialog.display<String>(
              enableOnlySingleSelection: true,
              selectedListData: [selectedText],
               context, listData: ["Salom","Xayr","Tursunali","Xorunaliyev"], choiceChipLabel: (a)=>a, validateSelectedItem: (list, val)=>list!.contains(val), onItemSearch: (item, query){
               
               return item.toLowerCase().contains(query.toLowerCase());
               
               }, onApplyButtonClick: (list){
                 
                 Navigator.pop(context);
               });
          
          }
        },
        child: Stack(
          children: [
            Container(
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                color: const Color(0xFFffffff),
                borderRadius: BorderRadius.circular(54),
                border: Border.all(width: 0.1),
              ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13, top: 13),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text:dataRojdeniya.isEmpty? widget.text:dataRojdeniya, style: GoogleFonts.montserrat(
                                fontWeight: widget.fontWeight,
                                fontSize: widget.size,
                    
                              color: const Color(0xFF444444))),
                      ]
                    ),
                  ),
                ),
              )
          ],
        ),
      ));
  }
}