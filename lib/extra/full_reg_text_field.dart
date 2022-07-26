import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FullRegistrTextField extends StatefulWidget {
  final String text;
  const FullRegistrTextField({Key? key, required this.text}) : super(key: key);

  @override
  State<FullRegistrTextField> createState() => _FullRegistrTextFieldState();
}

class _FullRegistrTextFieldState extends State<FullRegistrTextField> {
  bool isPrefix = true;
  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 11, right: 9),
      child: SizedBox(
        height: 38,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFffffff),
            borderRadius: BorderRadius.circular(54),
          ),
          child: Stack(
            children: [
              TextField(
                focusNode: focusNode,
                onChanged: (value) {
                  if (value.length == 1) {
                    isPrefix = false;
                    setState(() {});
                  }
                  if (value.isEmpty) {
                    isPrefix = true;
                    setState(() {});
                  }
                  
                },
                cursorHeight: 20,
                style: GoogleFonts.montserrat(fontSize: 14),
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
                ),
              ),
              isPrefix
                  ? Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => focusNode.requestFocus(),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: widget.text,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      color: const Color(0xFF444444))),
                              TextSpan(
                                  text: "*",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 10, color: Colors.red))
                            ]),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
