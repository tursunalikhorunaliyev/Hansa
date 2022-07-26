import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FlipCardAnimated extends StatefulWidget {
  const FlipCardAnimated({Key? key}) : super(key: key);

  @override
  State<FlipCardAnimated> createState() => _FlipCardAnimatedState();
}

class _FlipCardAnimatedState extends State<FlipCardAnimated> {
GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlipCard(
    key: cardKey,
    flipOnTouch: false,
    front:  RaisedButton(
      onPressed: () => cardKey.currentState!.toggleCard(),
      child: Text('Toggle'),
    ),
    back: Container(
      child: Text('Back'),
    ),
  ),
    );
    
  }
}



