import 'package:flutter/cupertino.dart';

class SelectableButtonController with ChangeNotifier {
  String _value = "";

  String get value => _value;

  set value(String newValue) {
    _value = newValue;
    notifyListeners();
  }
}
