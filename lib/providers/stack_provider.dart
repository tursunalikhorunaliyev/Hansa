import 'package:flutter/material.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';

class StackProvider extends ChangeNotifier{
  List<MenuActions> list = [];

  addStack(MenuActions action){
    
    list.add(action);
  
    notifyListeners();
  }
  removeStack(){
    list.removeAt(list.length-1);
    
  }
}