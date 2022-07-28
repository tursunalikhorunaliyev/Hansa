import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ExxxDropDown extends StatefulWidget {
  const ExxxDropDown({Key? key}) : super(key: key);

  @override
  State<ExxxDropDown> createState() => _ExxxDropDownState();
}

class _ExxxDropDownState extends State<ExxxDropDown> {
  final List<String> list = ['salom1', 'salom2', 'salom3'];
  var valueSel = "salom1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(valueSel),
            SizedBox(
              height: 50,
              width: 200,
              child: DropdownButton2<String>(
                hint: Text(valueSel),
                items: list
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(
                          e,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (e) {
                  setState(() {
                    valueSel = e!;
                  });
                },
                value: valueSel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
