import 'package:flutter/material.dart';
import 'package:todo_app/style/AppStyle.dart';
import 'package:todo_app/ui/home/HomeScreen.dart';
import 'package:todo_app/ui/login/LoginScreen.dart';
import 'package:todo_app/ui/register/RegisterScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        Homescreen.routeName:(_)=>Homescreen(),
      },
      initialRoute: Homescreen.routeName,
    );
  }
}
