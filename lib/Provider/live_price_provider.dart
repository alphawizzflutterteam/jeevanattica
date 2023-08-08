import 'package:flutter/material.dart';

class LivePriceProvider extends ChangeNotifier{
  String _gold1 = '',
      _gold2 = '';

  String get gold1 => _gold1;
  String get gold2 => _gold2;

  void setGold916(String val){
    _gold1 = val;
    notifyListeners();
  }
  void setGold999(String val){
    _gold2 = val;
    notifyListeners();
  }
}