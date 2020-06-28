import 'package:flutter/cupertino.dart';

class AnimationProvider with ChangeNotifier {
  double width=220,height=220;
  setValue(double height,double width) {
    this.height = height;
    this.width = width;
    notifyListeners();
  }
}
