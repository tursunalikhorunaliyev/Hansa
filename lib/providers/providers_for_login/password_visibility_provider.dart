import 'package:flutter/material.dart';
import 'package:hansa_app/drawer_widgets/change_profile.dart';

class PasswordVisibilityProvider extends ChangeNotifier{
  bool isVisible = false;

  void changeVisibility(){
    isVisible = !isVisible;
    notifyListeners();
  }
  bool get getVisibility => isVisible;
}