import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/firestore/FireStoreHandler.dart';
import 'package:todo_app/style/reusable_components/CustomFormField.dart';
import 'package:todo_app/style/reusable_components/CustomLodingDialog.dart';
import 'package:todo_app/style/reusable_components/CustomMessageDialog.dart';
import 'package:todo_app/style/reusable_components/constants.dart';

import '../../../firestore/model/Task.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  late TextEditingController titleController;
  late TextEditingController discriptionController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // I made this widget stateful to keep the same TextEditingController instance and preserve the text input across rebuilds
    super.initState();
    titleController = TextEditingController();
    discriptionController = TextEditingController();
  }
  @override
  void dispose() { // To close the controller with the screen so I enhance the app preform
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    discriptionController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Form(
      key: formKey,
      child: Padding(
        padding:  EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Add New Task",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: height*0.04,),
            CustomFormField(
                label: "Enter Task Title",
                controller: titleController,
                KeyboardType: TextInputType.text,
                validate: (value) {
                  if(value==null || value.isEmpty){
                    return "Please Enter Task Title";
                  }
                  return null;
                },),
            SizedBox(height: height*0.04,),
            CustomFormField(
                label: "Enter Discription of The Task",
                controller: discriptionController,
                KeyboardType: TextInputType.text,
                validate: (value) {
                  if(value==null || value.isEmpty){
                    return "Please Enter Discription of The Task";
                  }
                  return null;
                },),
            SizedBox(height: height*0.04,),
            InkWell(
                onTap: () {
                  showTaskDate();
                },
                child: Text(
                    selectedDate==null
                        ?"Date"
                        : DateFormat.yMd().format(selectedDate!), // Flutter intl package
                        // :"${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}",// or selectedDate!.toString(), // the ! is to tell the compiler that the value is not  null;
                    style: TextStyle(
                      fontSize: 18
                    ),
                )),
            SizedBox(height: height*0.04,),
            ElevatedButton(onPressed: () {
              AddTask();
            }, child: Text("Add Task"))
          ],
        ),
      ),
    );
  }
  DateTime? selectedDate; // DateTime returns Future<DateTime>
  showTaskDate()async{
    var date = await showDatePicker(
        context: context,
        initialDate: selectedDate??DateTime.now(), // If selectedDate is Null the initialDate will be Now
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(
          days: 365
        )),
    );
    setState(() {
      selectedDate = date;
    });
  }
  AddTask(){
    if(formKey.currentState!.validate()){
      if(selectedDate!=null){
        showDialog(context: context, builder: (context) => CustomLodingDialog(),);
        FireStoreHandler.creatTask(
            Task(
              title: titleController.text,
              description: discriptionController.text,
              date: Timestamp.fromMillisecondsSinceEpoch(selectedDate!.millisecondsSinceEpoch),
            ), FirebaseAuth.instance.currentUser!.uid);
        Navigator.pop(context);
        showDialog(context: context, builder: (context) => CustomMessageDialog(
            message: "Task Created Successfully",
            positiveBtnPress: (){
              Navigator.pop(context);
            }),);
      }
      else{
        ShowToast("Please Select Task Date");
      }
    }
  }
}

