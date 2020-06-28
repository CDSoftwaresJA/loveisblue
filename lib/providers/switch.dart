import 'package:flutter/cupertino.dart';
import 'package:loveisblue/utils/btcontrol.dart';

class SwitchState with ChangeNotifier {
  bool state = false;
  BTControl btControl = BTControl();
  setValue(bool state) {
    if (state==true){
      btControl.enableBLE();
      btControl.enableBeacon();
    }else{
      btControl.disableBLE();
      btControl.disableBeacon();
    }
    this.state = state;

    notifyListeners();
  }
}
