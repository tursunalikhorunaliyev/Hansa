import 'package:flutter/material.dart';

class GrisTest extends StatelessWidget {
  const GrisTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(color: Colors.pink, height: 80, width: 80),
          );
        },
      ),
    );
  }
}
