import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class IzbrannoeView extends ChangeNotifier {
  late bool isFavourite;
  setFavourite(fav) {
    isFavourite = fav;
    notifyListeners();
  }
}
