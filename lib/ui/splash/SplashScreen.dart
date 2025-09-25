import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:todo_app/ui/home/HomeScreen.dart';
import 'package:todo_app/ui/login/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "SplashScreen";
  const SplashScreen({super.key});

  @override

  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(
      seconds: 2
    ), (){
      NavigateToInitialScreen();
    });
  }
  NavigateToInitialScreen(){
    if(FirebaseAuth.instance.currentUser==null){
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }else{
      Navigator.pushReplacementNamed(context, Homescreen.routeName);
    }
  }
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          height: height*0.2,
          width: width*0.3,
          fit: BoxFit.fill,
        ).animate().scale(
          curve: Curves.fastOutSlowIn,
          duration: Duration(
            seconds: 2,
          )
        ),
      ),
    );
  }
}
