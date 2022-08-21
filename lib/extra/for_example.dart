import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:hansa_app/extra/full_registr.dart';
import 'package:hansa_app/extra/regis_widget.dart';
import 'package:provider/provider.dart';

class ForExampleUI extends StatelessWidget {
  const ForExampleUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flipCardController = Provider.of<FlipCardController>(context);
    return FlipCard(
      controller: flipCardController,
      flipOnTouch: false,
      back: const CompleteRegistr(),
      front: const FullRegistr(),
    );
  }
}
