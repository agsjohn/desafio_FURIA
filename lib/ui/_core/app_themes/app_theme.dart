import 'package:flutter/material.dart';
import 'package:my_app/ui/_core/app_colors.dart';

class AppTheme {
  Color mainColor = AppColors.mainColor;
  Color secondColor = AppColors.secondColor;

  AppTheme({required this.mainColor, required this.secondColor});

  get iconButtonStyle => ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    overlayColor: mainColor.withAlpha(50),
    elevation: 0,
    alignment: Alignment.center,
    backgroundColor: Color.fromARGB(0, 255, 255, 255),
  );

  get outlineButtonStyle => ButtonStyle(
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
    foregroundColor: WidgetStatePropertyAll(AppColors.lightBlack),
    side: WidgetStatePropertyAll(
      BorderSide(color: AppColors.lightBlack, width: 1),
    ),
    backgroundColor: WidgetStateColor.resolveWith((states) {
      return Colors.transparent;
    }),
  );

  ThemeData get appTheme => ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.lightBackgroundColor,
    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
    inputDecorationTheme: InputDecorationTheme(
      focusColor: mainColor,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          width: 2,
          style: BorderStyle.solid,
          color: mainColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(width: 1, style: BorderStyle.solid),
      ),
    ),
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
