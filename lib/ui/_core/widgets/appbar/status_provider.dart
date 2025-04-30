import 'package:flutter/material.dart';

class StatusProvider with ChangeNotifier {
  bool online = false;
  bool get isOnline => online;

  void setOnline(bool value) {
    online = value;
    notifyListeners();
  }
}
