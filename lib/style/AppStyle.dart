import 'package:flutter/material.dart';
import 'package:todo_app/style/AppColor.dart';

class AppStyle{
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      primary: AppColor.lightPrimary,
    ),
    scaffoldBackgroundColor: AppColor.lightBackgroun,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.lightPrimary,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColor.lightPrimary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.lightPrimary,
      toolbarHeight: 100,
      titleTextStyle: TextStyle(
        fontFamily: "Poppins",
        fontSize: 22,
        fontWeight: FontWeight.w700,

      ),
      iconTheme: IconThemeData(
        color: Colors.white
      )
    ),
    textTheme: TextTheme(
      labelSmall: TextStyle(
        color: Colors.black,
        fontSize: 12,
      ),
    ),
    useMaterial3: false,
  );
}