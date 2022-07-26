import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldForRekvizit extends StatefulWidget {
  String? hintText;
   TextFieldForRekvizit({Key? key, required this.hintText}) : super(key: key);

  @override
  State<TextFieldForRekvizit> createState() => _TextFieldForRekvizitState();
}

class _TextFieldForRekvizitState extends State<TextFieldForRekvizit> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 36,
        width: 269,
        decoration: BoxDecoration(
            color: const Color(0xFF000000),
            borderRadius: BorderRadius.circular(54)),
        child: TextField(
          style: GoogleFonts.montserrat(
              color: const Color(0xFFffffff), fontSize: 10),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(5),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(54)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(54)),
            hintText: widget.hintText,
            hintStyle: GoogleFonts.montserrat(
                fontSize: 10, color: const Color(0xFF767676)),
          ),
        ),
      );
  }
}