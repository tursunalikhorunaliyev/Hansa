import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneFormatterTest extends StatefulWidget {
  const PhoneFormatterTest({Key? key}) : super(key: key);

  @override
  State<PhoneFormatterTest> createState() => _PhoneFromatteTestrState();
}

class _PhoneFromatteTestrState extends State<PhoneFormatterTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InternationalPhoneNumberInput(
            onInputChanged: (value) {},
            autoValidateMode: AutovalidateMode.onUserInteraction,
            inputDecoration: inputDecoration(),
            keyboardType: TextInputType.number,
            selectorTextStyle: style(),
            textStyle: style(),
            selectorConfig: SelectorConfig(
              leadingPadding: 13,
              useEmoji: false,
              setSelectorButtonAsPrefixIcon: true,
              selectorType: PhoneInputSelectorType.DROPDOWN,
            ),
          ),
          InternationalPhoneNumberInput(
            onInputChanged: (value) {},
            autoValidateMode: AutovalidateMode.onUserInteraction,
            inputDecoration: inputDecoration(),
            keyboardType: TextInputType.number,
            selectorTextStyle: style(),
            textStyle: style(),
            selectorConfig: SelectorConfig(
                leadingPadding: 13,
                useEmoji: false,
                setSelectorButtonAsPrefixIcon: true,
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
          ),
          InternationalPhoneNumberInput(
            onInputChanged: (value) {},
            autoValidateMode: AutovalidateMode.onUserInteraction,
            inputDecoration: inputDecoration(),
            keyboardType: TextInputType.number,
            selectorTextStyle: style(),
            textStyle: style(),
            selectorConfig: SelectorConfig(
              leadingPadding: 13,
              useEmoji: false,
              setSelectorButtonAsPrefixIcon: true,
              selectorType: PhoneInputSelectorType.DIALOG,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 0.9, color: Colors.grey),
        borderRadius: BorderRadius.circular(54),
      ),
      focusedErrorBorder: outlineInputBorder(),
      enabledBorder: outlineInputBorder(),
      errorBorder: outlineInputBorder(),
      contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 13),
      hintStyle: style(),
    );
  }

  OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(width: 0.1),
        borderRadius: BorderRadius.circular(54));
  }

  TextStyle style() {
    return GoogleFonts.montserrat(
      fontWeight: FontWeight.normal,
      fontSize: 10,
      color: const Color(0xFF444444),
    );
  }
}
