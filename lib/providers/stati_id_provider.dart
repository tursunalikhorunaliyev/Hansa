import 'dart:developer';

import 'package:flutter/cupertino.dart';

class StatiIdProvider extends ChangeNotifier {
  String index = "0";
  String get getIndex => index;
  changeIndex(String index) {
    this.index = index;
    log(index + '   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    log(this.index + '    <<<<<<<<<<<<<<<<<<<<<<<<<<<<<');
    notifyListeners();
  }
}
