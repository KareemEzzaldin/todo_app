import 'package:flutter/material.dart';
import 'package:todo_app/style/AppStyle.dart';
import 'package:todo_app/style/reusable_components/CustomButton.dart';
import 'package:todo_app/style/reusable_components/CustomFormField.dart';
import 'package:todo_app/style/reusable_components/constants.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "RegisterScreen";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/dark_bg.png"),
        )
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Create Account"),
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
                      controller: nameController,
                        label: "Full Name",
                        KeyboardType: TextInputType.name,
                        validate:(value){
                          if(value==null || value.isEmpty){
                            return "Please Enter your name";
                          }
                          return null;
                        },
                    ),
                    SizedBox(
                      height: height*0.01,),
                    CustomFormField(
                      controller: emailController,
                        label: "Email Address",
                        KeyboardType: TextInputType.emailAddress,
                        validate: (value){
                          if(value==null || value.isEmpty){
                            return "Please Enter your email";
                          }
                          if(!ValidateEmail(value)){
                            return "Enter valid email";
                          }
                          return null;
                        },
                    ),
                    SizedBox(
                      height: height*0.01,),
                    CustomFormField(
                      controller: passwordController,
                      label: "Password",
                      KeyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      validate: (value){
                        if(value==null || value.isEmpty){
                          return "Please Enter your password";
                        }
                        if(value.length < 6){
                          return "your password should at least 6 chars";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height*0.01,),
                    CustomFormField(
                      controller: repasswordController,
                      label: "ReEnter Password",
                      KeyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      validate: (value){
                        if(value != passwordController.text){
                          return "Password validation is wrong";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height*0.05,),
                    CustomButton(
                      label: "Create Account",
                      onClick: (){
                          creatAccount();
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  creatAccount(){
    if(formKey.currentState!.validate()){
      //creat account
    }
  }
}

