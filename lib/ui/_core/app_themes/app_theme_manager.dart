import 'package:flutter/material.dart';
import 'package:furia_chat_bot/ui/_core/app_colors.dart';
import 'package:furia_chat_bot/ui/_core/app_themes/app_theme.dart';

class AppThemeManager with ChangeNotifier {
  bool useTheme1 = true;
  late AppTheme appTheme = appTheme1;

  AppTheme appTheme1 = AppTheme(
    mainColor: AppColors.mainColor,
    secondColor: AppColors.secondColor,
  );

  AppTheme appTheme2 = AppTheme(
    mainColor: AppColors.mainColor1,
    secondColor: AppColors.secondColor1,
  );

  bool get isTheme1 => useTheme1;

  ThemeData get theme => appTheme.appTheme;

  Color get mainColor => appTheme.mainColor;

  ButtonStyle get iconButtonStyle => appTheme.iconButtonStyle;

  ButtonStyle get outlineButtonStyle => appTheme.outlineButtonStyle;

  void toggleTheme() {
    useTheme1 = !useTheme1;
    if (useTheme1 == false) {
      appTheme = appTheme2;
    } else {
      appTheme = appTheme1;
    }
    notifyListeners();
  }
}
