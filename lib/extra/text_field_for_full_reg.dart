import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TextFieldForFullRegister extends StatefulWidget {
  final String text;
  final double height;
  final double size;
  final FontWeight weight;
  final TextEditingController textEditingController;
  const TextFieldForFullRegister(
      {Key? key,
      required this.text,
      required this.height,
      required this.size,
      required this.weight,
      required this.textEditingController})
      : super(key: key);
  @override
  State<TextFieldForFullRegister> createState() =>
      _TextFieldForFullRegisterState();
}

class _TextFieldForFullRegisterState extends State<TextFieldForFullRegister> {
  bool isHint = true;
  final focusNode = FocusNode();
  

  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 11, right: 9),
      child: SizedBox(
        height: widget.height,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFffffff),
                borderRadius: BorderRadius.circular(54),
              ),
              child: TextField(
                focusNode: focusNode,
                controller: widget.textEditingController,
                onChanged: (value) {
                  if (value.isEmpty) {
                    isHint = true;
                    setState(() {});
                  } else if (value.length == 1) {
                    isHint = false;
                    setState(() {});
                  }
                },
                cursorHeight: 15,
                style: GoogleFonts.montserrat(
                                fontSize: isTablet ? 13 : 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0.9, color: Colors.grey),
                    borderRadius: BorderRadius.circular(54),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0.1),
                      borderRadius: BorderRadius.circular(54)),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 13),
                  hintStyle: GoogleFonts.montserrat(
                      fontWeight: widget.weight,
                      fontSize: widget.size,
                      color: const Color(0xFF444444)),
                ),
              ),
            ),
            isHint
                ? Padding(
                    padding: const EdgeInsets.only(left: 13),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => focusNode.requestFocus(),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: widget.text,
                              style: GoogleFonts.montserrat(
                                  fontWeight: widget.weight,
                                  fontSize: widget.size,
                                  color: const Color(0xFF444444))),
                          TextSpan(
                              text: "*",
                              style: GoogleFonts.montserrat(
                                  fontWeight: widget.weight,
                                  fontSize: widget.size,
                                  color: Colors.red))
                        ])),
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
