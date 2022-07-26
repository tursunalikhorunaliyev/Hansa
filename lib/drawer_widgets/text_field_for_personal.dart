import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldForPersonal extends StatefulWidget {
 final String? text;
 final TextEditingController? controller;
 const TextFieldForPersonal({Key? key, required this.text, required this.controller})
      : super(key: key);

  @override
  State<TextFieldForPersonal> createState() => _TextFieldForPersonalState();
}

class _TextFieldForPersonalState extends State<TextFieldForPersonal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 269,
      decoration: BoxDecoration(
          color: const Color(0xFF000000),
          borderRadius: BorderRadius.circular(54)),
      child: TextField(
        onTap: () {
          setState(() {
            widget.controller!.text = "";
          });
        },
        textDirection: TextDirection.rtl,
        controller: widget.controller!,
        style: GoogleFonts.montserrat(
            color: const Color(0xFFffffff), fontSize: 10),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.text.toString(),
              style: GoogleFonts.montserrat(
                  fontSize: 10, color: const Color(0xFF767676)),
            ),
          ),
          contentPadding: const EdgeInsets.all(10),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(54)),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(54)),
        ),
      ),
    );
  }
}
