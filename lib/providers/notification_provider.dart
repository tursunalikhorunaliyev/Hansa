import 'package:flutter/cupertino.dart';

class NotificationProvider extends ChangeNotifier {
  bool notificationDetecting = false;
  bool get getDetectedValue => notificationDetecting;
  changeDetector(bool newValue) {
    notificationDetecting = newValue;
    notifyListeners();
  }
}
