import 'package:flutter/material.dart';
import 'package:hansa_app/extra/text_field_for_full_reg.dart';

class EmptyScreen extends StatefulWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  State<EmptyScreen> createState() => _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen> {
  @override
  void initState() {
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TextFieldForFullRegister(text: "salom", height: 38, size: 10, weight: FontWeight.normal),
      )
    );
  }
}
