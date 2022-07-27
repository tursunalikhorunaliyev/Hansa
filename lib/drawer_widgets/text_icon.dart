import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
//Sahar 9 da
class TextIcon extends StatefulWidget {
  String? text;
  String? iconUrl;
  Color rang;
  Color colorIcon;

  TextIcon(
      {Key? key,
      required this.text,
      required this.iconUrl,
      this.rang = const Color(0xFFffffff), this.colorIcon = const Color(0xFFffffff)})
      : super(key: key);

  @override
  State<TextIcon> createState() => _TextIconState();
}

class _TextIconState extends State<TextIcon> {
  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    return Row(
      children: [
        Image.asset(
          widget.iconUrl.toString(),
          height: 20,
          width: 20,
          color: widget.colorIcon,
        ),
        const SizedBox(
          width: 22,
        ),
        Text(
          widget.text.toString(),
          style: GoogleFonts.montserrat(fontSize: isTablet ? 18  : 13, color: widget.rang),
        )
      ],
    );
  }
}
