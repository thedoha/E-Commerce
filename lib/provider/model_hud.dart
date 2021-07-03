import 'package:flutter/cupertino.dart';

class ModelHud extends ChangeNotifier
 {
  bool isLoading=false;

  changeIsloading(bool value)
  {
    isLoading=value;
    notifyListeners();
  }

}