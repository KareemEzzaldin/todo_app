import 'package:flutter/material.dart';
import 'package:todo_app/style/AppStyle.dart';
import 'package:todo_app/ui/login/LoginScreen.dart';
import 'package:todo_app/ui/register/RegisterScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppStyle.lightTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName:(_)=>LoginScreen(),
        RegisterScreen.routeName:(_)=>RegisterScreen(),
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
