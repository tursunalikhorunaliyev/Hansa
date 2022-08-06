import 'package:flutter/material.dart';

class HamburgerIcon extends StatelessWidget {
  final Color color;
  const HamburgerIcon({this.color = Colors.black, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Divider(
          endIndent: 8,
          height: 5,
          thickness: 2,
          color: color,
        ),
        Divider(
          endIndent: 15,
          height: 5,
          thickness: 2,
          color: color,
        ),
        Divider(
          endIndent: 15,
          height: 5,
          thickness: 2,
          color: color,
        ),
        Divider(
          endIndent: 8,
          height: 5,
          thickness: 2,
          color: color,
        ),
      ],
    );
  }
}
