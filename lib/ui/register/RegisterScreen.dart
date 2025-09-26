import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/firestore/model/User.dart' as MyUser;
import 'package:flutter/material.dart';
import 'package:todo_app/firestore/FireStoreHandler.dart';
import 'package:todo_app/style/AppStyle.dart';
import 'package:todo_app/style/reusable_components/CustomButton.dart';
import 'package:todo_app/style/reusable_components/CustomFormField.dart';
import 'package:todo_app/style/reusable_components/CustomLodingDialog.dart';
import 'package:todo_app/style/reusable_components/CustomMessageDialog.dart';
import 'package:todo_app/style/reusable_components/FireBaseAuthCodes.dart';
import 'package:todo_app/style/reusable_components/constants.dart';

import '../home/HomeScreen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController repasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        )
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
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
                    SizedBox(height: height*0.01,),
                    CustomFormField(
                      controller: ageController,
                      maxLength: 2  ,
                      label: "Age",
                      KeyboardType: TextInputType.number,
                      validate:(value){
                        if(value==null || value.isEmpty){
                          return "Please Enter Age";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height*0.01,),
                    CustomFormField(
                      controller: phoneController,
                      maxLength: 11,
                      label: "Phone Number",
                      KeyboardType: TextInputType.phone,
                      validate:(value){
                        if(value==null || value.isEmpty){
                          return "Please Enter Phone Number";
                        }
                        if(value.length < 11){
                          return "Enter a Valid Phone Number";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height*0.01,),
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
                    SizedBox(height: height*0.01,),
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
                    SizedBox(height: height*0.01,),
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

  creatAccount() async{
    if(formKey.currentState!.validate()){
      // call firebase to create account
      try {
        showDialog(context: context, builder: (context) => CustomLodingDialog(),);
         UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
         await FireStoreHandler.creatUser(MyUser.User(
           ID: userCredential.user!.uid,
           fullName: nameController.text,
           Age: int.parse(ageController.text),
           email: emailController.text,
           phone: phoneController.text,
         ));
         Navigator.pushNamedAndRemoveUntil(context, Homescreen.routeName, (route)=> false);
        // userCredential.user?.
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        if (e.code == FireBaseAuthCodes.WeekPassword) {
          showDialog(context: context, builder: (context) => CustomMessageDialog(
            message: "The password provided is too weak.", positiveBtnPress: () {
            Navigator.pop(context);
          },),);
        } else if (e.code == FireBaseAuthCodes.EmailAlreadyInUse) {
          showDialog(context: context, builder: (context) => CustomMessageDialog(
            message: "The account already exists for that email.", positiveBtnPress: () {
            Navigator.pop(context);
          },),);
        }
      } catch (error) {
        Navigator.pop(context);
        showDialog(context: context, builder: (context) => CustomMessageDialog(
            message: error.toString(), positiveBtnPress: () {
              Navigator.pop(context);
            },),);
      }
    }
  }
}

