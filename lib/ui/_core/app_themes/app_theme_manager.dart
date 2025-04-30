import 'package:flutter/material.dart';
import 'app_theme1.dart';
import 'app_theme2.dart';

class AppThemeManager with ChangeNotifier {
  bool useTheme1 = true;

  bool get isTheme1 => useTheme1;

  ThemeData get theme => useTheme1 ? AppTheme1.appTheme : AppTheme2.appTheme;

  Color get mainColor => useTheme1 ? AppTheme1.mainColor : AppTheme2.mainColor;

  ButtonStyle get iconButtonStyle =>
      useTheme1 ? AppTheme1.iconButtonStyle : AppTheme2.iconButtonStyle;

  ButtonStyle get outlineButtonStyle =>
      useTheme1 ? AppTheme1.outlineButtonStyle : AppTheme2.outlineButtonStyle;

  void toggleTheme() {
    useTheme1 = !useTheme1;
    notifyListeners();
  }
}
