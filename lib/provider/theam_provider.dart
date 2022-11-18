import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{

  bool isLight = false;

  void changeTheme(){
    isLight = !isLight;
    notifyListeners();

  }

}