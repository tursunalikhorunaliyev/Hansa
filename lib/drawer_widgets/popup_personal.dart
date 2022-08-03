import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PopupPersonal extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  PopupPersonal({Key? key, required this.controller}) : super(key: key);

  @override
  State<PopupPersonal> createState() => _PopupPersonalState();
}

class _PopupPersonalState extends State<PopupPersonal> {
  double height = 36;
  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);

    return InkWell(
      onTap: () {
        setState(() {
          height == 36 ? 50 : 36;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        height: isTablet ? 45 : height,
        width: isTablet ? 350 : 269,
        decoration: BoxDecoration(
            color: const Color(0xFF000000),
            borderRadius: BorderRadius.circular(54)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Магазин",
                style: GoogleFonts.montserrat(
                    fontSize: isTablet ? 13 : 10,
                    color: const Color(0xFF767676)),
              ),
              /*  const SizedBox(
                width: 100,
              ), */
              Text(
                widget.controller.text,
                style: GoogleFonts.montserrat(
                    color: const Color(0xFFffffff), fontSize: 10),
              )
            ],
          ),
        ),
      ),
    );
  }
}
