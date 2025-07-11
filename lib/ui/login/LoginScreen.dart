import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/style/reusable_components/FireBaseAuthCodes.dart';
import 'package:todo_app/ui/home/HomeScreen.dart';
import 'package:todo_app/ui/register/RegisterScreen.dart';

import '../../style/reusable_components/CustomButton.dart';
import '../../style/reusable_components/CustomFormField.dart';
import '../../style/reusable_components/constants.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Login"),
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomFormField(
                      controller: emailController,
                      label: "Email Address",
                      KeyboardType: TextInputType.emailAddress,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter your email";
                        }
                        if (!ValidateEmail(value)) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.01,),
                    CustomFormField(
                      controller: passwordController,
                      label: "Password",
                      KeyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter your password";
                        }
                        if (value.length < 6) {
                          return "your password should at least 6 chars";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.01,),
                    CustomButton(
                      label: "Login",
                      onClick: () {
                        login();
                      },
                    ),
                    SizedBox(
                      height: height * 0.01,),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RegisterScreen.routeName);
                        },
                        child: Text("Creat New Account",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    if (formKey.currentState!.validate() == true) {
      // login
      try {
        UserCredential credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text);
        Navigator.pushReplacementNamed(context, Homescreen.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == FireBaseAuthCodes.UserNotFound) {
          print('No user found for that email.');
        } else if (e.code == FireBaseAuthCodes.WeekPassword) {
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}

