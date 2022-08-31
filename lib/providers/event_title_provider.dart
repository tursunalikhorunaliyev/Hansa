import 'package:flutter/material.dart';

class EventTitleProvider extends ChangeNotifier {
  String get getTitle => title;
  String title = "Записаться";
  changeTitle(String newTitle) {
    title = newTitle;
    notifyListeners();
  }
}
