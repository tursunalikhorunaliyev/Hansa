import 'package:flutter/material.dart';

class ProviderOtpravitRassilku extends ChangeNotifier {
  Alignment? alignment;

  setAlignment(Alignment alignment){
    this.alignment = alignment;
    notifyListeners();
  } 

  Alignment get getAlignment => alignment!;
}