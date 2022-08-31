import 'package:flutter/cupertino.dart';

class ProviderOtpravitPushUvodamleniya extends ChangeNotifier {
  Alignment? alignment;

  setAlignment(Alignment alignment) {
    this.alignment = alignment;
    notifyListeners();
  }

  Alignment get getAlignment => alignment!;
}
