import 'package:flutter/material.dart';
import 'package:todo_app/style/AppColor.dart';

class AppStyle{
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      primary: AppColor.lightPrimary,
    ),
    textTheme: TextTheme(
      labelSmall: TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
    ),
    useMaterial3: true,
  );
}