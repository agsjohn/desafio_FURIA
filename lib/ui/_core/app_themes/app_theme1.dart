import 'package:flutter/material.dart';
import 'package:my_app/ui/_core/app_colors.dart';

abstract class AppTheme1 {
  static const Color mainColor = AppColors.mainColor;
  static const Color secondColor = AppColors.secondColor;

  static get iconButtonStyle => ElevatedButton.styleFrom(
    overlayColor: mainColor.withAlpha(50),
    elevation: 0,
    backgroundColor: Color.fromARGB(0, 255, 255, 255),
  );

  static get outlineButtonStyle => ButtonStyle(
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
    foregroundColor: WidgetStatePropertyAll(AppColors.lightBlack),
    side: WidgetStatePropertyAll(
      BorderSide(color: AppColors.lightBlack, width: 1),
    ),
    backgroundColor: WidgetStateColor.resolveWith((states) {
      return Colors.transparent;
    }),
  );

  static ThemeData get appTheme => ThemeData.dark().copyWith(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Colors.black),
        backgroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey;
          } else if (states.contains(WidgetState.pressed)) {
            return secondColor;
          } else {
            return mainColor;
          }
        }),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStatePropertyAll(mainColor.withAlpha(50)),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.lightBlack;
          } else {
            return mainColor;
          }
        }),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(color: AppColors.lightBlack, width: 1);
          } else {
            return BorderSide(color: mainColor, width: 1);
          }
        }),
        backgroundColor: WidgetStateColor.resolveWith((states) {
          return Colors.transparent;
        }),
      ),
    ),
  );
}
