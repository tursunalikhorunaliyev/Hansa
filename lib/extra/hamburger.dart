import 'package:flutter/material.dart';

class HamburgerIcon extends StatelessWidget {
  const HamburgerIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const[
         Divider(
          endIndent: 5,
          height: 5,
          thickness: 2,
          color: Colors.black,
        ),
        Divider(
          endIndent: 5,
          height: 5,
          thickness: 2,
          color: Colors.black,
        ),
        Divider(
          endIndent: 5,
          height: 5,
          thickness: 2,
          color: Colors.black,
        ),
        Divider(
          endIndent: 5,
          height: 5,
          thickness: 2,
          color: Colors.black,
        ),
      ],
    );
  }
}
