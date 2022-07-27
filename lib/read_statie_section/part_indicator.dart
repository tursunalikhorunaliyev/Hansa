// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class PartIndicator extends StatelessWidget {
  PartIndicator({Key? key, required this.icon}) : super(key: key);
  Widget icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            width: 70.33333333333333,
            decoration: const BoxDecoration(
                color: Color(0XFFff163e),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(21),
                    bottomRight: Radius.circular(21))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.5),
              child: icon,
            ),
          ),
        ),
        Image.asset(
          "assets/#Статьи .png",
          height: 100,
          width: 100,
        )
      ],
    );
  }
}
