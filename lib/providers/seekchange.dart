
import 'package:flutter/cupertino.dart';


class SeekChange with ChangeNotifier {
  double sensitivity = 50.0;
  setValue(double sensitivity) {
    this.sensitivity = sensitivity;
    notifyListeners();
  }
}
