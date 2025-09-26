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

class EditTask extends StatefulWidget {
  final Task task;

  const EditTask({super.key, required this.task});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.description);
    selectedDate = widget.task.date?.toDate();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Center(
        child: Text(
          "Edit Task",
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomFormField(
                label: "Task Title",
                controller: titleController,
                KeyboardType: TextInputType.text,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Task Title";
                  }
                  return null;
                },
              ),
              SizedBox(height: height * 0.03),
              CustomFormField(
                label: "Task Description",
                controller: descriptionController,
                KeyboardType: TextInputType.text,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Task Description";
                  }
                  return null;
                },
              ),
              SizedBox(height: height * 0.03),
              InkWell(
                onTap: () {
                  showTaskDate();
                },
                child: Text(
                  selectedDate == null
                      ? "Select Date"
                      : DateFormat.yMd().format(selectedDate!),
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              updateTask();
            },
            child: Text("Save Changes"),
          ),
        ),
      ],
    );
  }

  showTaskDate() async {
    var date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    setState(() {
      selectedDate = date;
    });
  }

  updateTask() {
    if (formKey.currentState!.validate()) {
      if (selectedDate != null) {
        showDialog(
          context: context,
          builder: (context) => CustomLodingDialog(),
        );
        FireStoreHandler.updateTask(
          widget.task.id!,
          Task(
            id: widget.task.id,
            title: titleController.text,
            description: descriptionController.text,
            date: Timestamp.fromMillisecondsSinceEpoch(
                selectedDate!.millisecondsSinceEpoch),
          ),
          FirebaseAuth.instance.currentUser!.uid,
        );
        Navigator.pop(context);
        Navigator.pop(context); // close dialog
        showDialog(
          context: context,
          builder: (context) => CustomMessageDialog(
            message: "Task Updated Successfully",
            positiveBtnPress: () {
              Navigator.pop(context);
            },
          ),
        );
      } else {
        ShowToast("Please Select Task Date");
      }
    }
  }
}
